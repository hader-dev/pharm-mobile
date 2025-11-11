import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/deeplinks/deeplinks_service.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:share_plus/share_plus.dart';

part 'medicine_details_state.dart';

class MedicineDetailsCubit extends Cubit<MedicineDetailsState> {
  final MedicineCatalogRepository medicineCatalogRepository;
  final OrderRepository ordersRepository;
  final FavoriteRepository favoriteRepository;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  MedicineDetailsCubit(
      {required this.medicineCatalogRepository,
      required TextEditingController packageQuantityController,
      required TextEditingController quantityController,
      required TabController tabController,
      required this.ordersRepository,
      String shippingAddress = "",
      required this.favoriteRepository})
      : super(MedicineDetailsInitial(
            tabController: tabController,
            shippingAddress: shippingAddress,
            quantityController: quantityController,
            packageQuantityController: packageQuantityController)) {
    state.quantityController.addListener(() {
      if (int.parse(state.quantityController.text) <= 0) {
        state.quantityController.text = '1';
      }
    });
  }
  Future<bool> likeMedicine() async {
    try {
      emit(state.toLoaded(
        state.medicineCatalogData.copyWith(isLiked: true),
      ));
      await favoriteRepository.likeMedicineCatalog(
          medicineCatalogId: state.medicineCatalogData.id);
      return true;
    } catch (e) {
      emit(state.toLoaded(state.medicineCatalogData.copyWith(isLiked: false)));
      GlobalExceptionHandler.handle(exception: e);
      return false;
    }
  }

  Future<bool> unlikeMedicine() async {
    try {
      await favoriteRepository.unLikeMedicineCatalog(
          medicineCatalogId: state.medicineCatalogData.id);
      emit(state
          .toToggleLiked(state.medicineCatalogData.copyWith(isLiked: false)));

      return false;
    } catch (e) {
      emit(state.toToggleLiked(
        state.medicineCatalogData.copyWith(isLiked: true),
      ));
      GlobalExceptionHandler.handle(exception: e);
      return true;
    }
  }

  Future<void> getMedicineCatalogData(String id) async {
    try {
      emit(state.toLoading());
      final medicineCatalogData =
          await medicineCatalogRepository.getMedicineCatalogById(id);
      emit(state.toLoaded(medicineCatalogData));
    } catch (e) {
      emit(state.toLoadError());
    }
  }

  void shareProduct() async {
    if (state.medicineCatalogData.id.isNotEmpty) {
      try {
        final product = state.medicineCatalogData;

        final deepLinkUrl =
            '${DeeplinksService.scheme}://${DeeplinksService.host}/product/medicine/${product.id}';

        await SharePlus.instance
            .share(ShareParams(uri: Uri.parse(deepLinkUrl)));
      } catch (e) {
        GlobalExceptionHandler.handle(exception: e);
      }
    }
  }

  void changeTapIndex(int index) {
    emit(state.toTapIndexChanged(index));
  }

  void incrementQuantity() {
    final updatedQuantity = int.parse(state.quantityController.text) + 1;
    state.quantityController.text = (updatedQuantity).toString();

    state.packageQuantityController.text =
        (updatedQuantity ~/ (state.medicineCatalogData.packageSize)).toString();
    emit(state.toQuantityChanged());
  }

  void decrementQuantity() {
    final updatedQuantity = int.parse(state.quantityController.text) - 1;
    if (updatedQuantity > 0) {
      state.quantityController.text = (updatedQuantity).toString();

      state.packageQuantityController.text =
          (updatedQuantity ~/ (state.medicineCatalogData.packageSize))
              .toString();
    }
    emit(state.toQuantityChanged());
  }

  void incrementPackageQuantity() {
    final currPackageQuantity =
        int.parse(state.packageQuantityController.text) + 1;

    state.packageQuantityController.text = currPackageQuantity.toString();
    state.quantityController.text =
        (currPackageQuantity * (state.medicineCatalogData.packageSize))
            .toString();
    emit(state.toQuantityChanged());
  }

  void decrementPackageQuantity() {
    final currPackageQuantity =
        int.parse(state.packageQuantityController.text) - 1;

    final updatedItemQuantity =
        (currPackageQuantity * (state.medicineCatalogData.packageSize));

    state.packageQuantityController.text =
        (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    state.quantityController.text =
        (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(state.toQuantityChanged());
  }

  Future<bool> passQuickOrder() async {
    if (formKey.currentState?.validate() == false) return false;

    try {
      emit(state.toPassingQuickOrder());
      await ordersRepository.createQuickOrder(
          orderDetails: CreateQuickOrderModel(
        deliveryAddress: state.shippingAddress,
        deliveryTownId: getItInstance.get<UserManager>().currentUser.townId,
        medicineCatalogId: state.medicineCatalogData.id,
        qty: int.parse(state.quantityController.text),
      ));
      emit(state.toQuickOrderPassed());
      return true;
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLoadError());
      return false;
    }
  }

  void updateShippingAddress(String value) {
    emit(state.toUpdateShippingAddress(value));
  }

  void updateQuantity(String v) {
    final updatedQuantity = int.parse(v);
    if (updatedQuantity > 0) {
      state.quantityController.text = (updatedQuantity).toString();

      state.packageQuantityController.text =
          (updatedQuantity ~/ (state.medicineCatalogData.packageSize))
              .toString();
    }
    emit(state.toQuantityChanged());
  }

  void updateQuantityPackage(String v) {
    final currPackageQuantity = int.parse(v);

    final updatedItemQuantity =
        (currPackageQuantity * (state.medicineCatalogData.packageSize));

    state.packageQuantityController.text =
        (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    state.quantityController.text =
        (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(state.toQuantityChanged());
  }
}
