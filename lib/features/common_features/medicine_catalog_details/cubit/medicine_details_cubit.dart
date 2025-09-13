import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:share_plus/share_plus.dart';

part 'medicine_details_state.dart';

class MedicineDetailsCubit extends Cubit<MedicineDetailsState> {
  final TextEditingController quantityController;

  final MedicineCatalogRepository medicineCatalogRepository;
  final OrderRepository ordersRepository;
  final FavoriteRepository favoriteRepository;
  final TabController tabController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  MedicineDetailsCubit(
      {required this.medicineCatalogRepository,
      required this.quantityController,
      required this.tabController,
      required this.ordersRepository,
      String shippingAddress = "",
      required this.favoriteRepository})
      : super(MedicineDetailsInitial(shippingAddress: shippingAddress)) {
    quantityController.addListener(() {
      if (int.parse(quantityController.text) <= 0) {
        quantityController.text = '1';
      }
    });
  }
  Future<void> likeMedicine() async {
    if (state.medicineCatalogData == null) return;
    try {
      emit(state.loaded(
        state.medicineCatalogData!.copyWith(isLiked: true),
      ));
      await favoriteRepository.likeMedicineCatalog(
          medicineCatalogId: state.medicineCatalogData!.id);
    } catch (e) {
      emit(state.loaded(state.medicineCatalogData!.copyWith(isLiked: false)));
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  Future<void> unlikeMedicine() async {
    if (state.medicineCatalogData != null) {
      try {
        emit(state.loaded(state.medicineCatalogData!.copyWith(isLiked: false)));
        await favoriteRepository.unLikeMedicineCatalog(
            medicineCatalogId: state.medicineCatalogData!.id);
      } catch (e) {
        state.medicineCatalogData!.isLiked = true;
        emit(state.loaded(
          state.medicineCatalogData!.copyWith(isLiked: true),
        ));
        GlobalExceptionHandler.handle(exception: e);
      }
    }
  }

  getMedicineCatalogData(String id) async {
    try {
      emit(state.loading());
      final medicineCatalogData =
          await medicineCatalogRepository.getMedicineCatalogById(id);
      emit(state.loaded(medicineCatalogData));
    } catch (e) {
      emit(state.loadError());
    }
  }

  void shareProduct() async {
    if (state.medicineCatalogData != null) {
      try {
        final product = state.medicineCatalogData!;

        final deepLinkUrl =
            'https://hader-pharm.com/product/medicine/${product.id}';

        await SharePlus.instance
            .share(ShareParams(uri: Uri.parse(deepLinkUrl)));
      } catch (e) {
        GlobalExceptionHandler.handle(exception: e);
      }
    }
  }

  void changeTapIndex(int index) {
    emit(state.tapIndexChanged(index));
  }

  void incrementQuantity() {
    quantityController.text =
        (int.parse(quantityController.text) + 1).toString();
    emit(state.quantityChanged());
  }

  void decrementQuantity() {
    if (int.parse(quantityController.text) > 1) {
      quantityController.text =
          (int.parse(quantityController.text) - 1).toString();
    }
    emit(state.quantityChanged());
  }

  Future<bool> passQuickOrder() async {
    if (formKey.currentState?.validate() == false) return false;

    try {
      emit(state.passingQuickOrder());
      await ordersRepository.createQuickOrder(
          orderDetails: CreateQuickOrderModel(
        deliveryAddress: state.shippingAddress,
        deliveryTownId: getItInstance.get<UserManager>().currentUser.townId,
        medicineCatalogId: state.medicineCatalogData!.id,
        qty: int.parse(quantityController.text),
      ));
      emit(state.quickOrderPassed());
      return true;
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.loadError());
      return false;
    }
  }

  void updateShippingAddress(String value) {
    emit(state.initial(shippingAddress: value));
  }
}
