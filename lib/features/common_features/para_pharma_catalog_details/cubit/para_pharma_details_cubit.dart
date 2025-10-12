import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:share_plus/share_plus.dart';

part 'para_pharma_details_state.dart';

class ParaPharmaDetailsCubit extends Cubit<ParaPharmaDetailsState> {
  ParaPharmaCatalogModel? paraPharmaCatalogData;
  int currentTapIndex = 0;
  final ParaPharmaRepository paraPharmaCatalogRepository;
  final TabController tabController;
  final OrderRepository ordersRepository;
  final FavoriteRepository favoriteRepository;

  final TextEditingController quantityController;
  final TextEditingController packageQuantityController;

  final GlobalKey<FormFieldState<dynamic>> shippingAddressKey = GlobalKey();

  ParaPharmaDetailsCubit(
      {required this.quantityController,
      required this.packageQuantityController,
      required this.paraPharmaCatalogRepository,
      required this.tabController,
      required this.favoriteRepository,
      required this.ordersRepository})
      : super(ParaPharmaDetailsInitial());

  Future<void> getParaPharmaCatalogData(String id) async {
    try {
      emit(ParaPharmaDetailsLoading());
      paraPharmaCatalogData =
          await paraPharmaCatalogRepository.getParaPharmaCatalogById(id);
      emit(ParaPharmaDetailsLoaded());
    } catch (e) {
      debugPrint(e.toString());
      emit(ParaPharmaDetailsLoadError());
    }
  }

  Future<bool> likeParaPharma() async {
    if (paraPharmaCatalogData != null) {
      try {
        paraPharmaCatalogData!.isLiked = true;
        emit(ParaPharmaDetailsLoaded());
        await favoriteRepository.likeParaPharmaCatalog(
            paraPharmaCatalogId: paraPharmaCatalogData!.id);

        return true;
      } catch (e) {
        paraPharmaCatalogData!.isLiked = false;
        emit(ParaPharmaDetailsLoaded());
        GlobalExceptionHandler.handle(exception: e);
        return false;
      }
    }
    return false;
  }

  Future<bool> unlikeParaPharma() async {
    if (paraPharmaCatalogData != null) {
      try {
        paraPharmaCatalogData!.isLiked = false;
        emit(ParaPharmaDetailsLoaded());
        await favoriteRepository.unLikeParaPharmaCatalog(
            paraPharmaCatalogId: paraPharmaCatalogData!.id);
        return false;
      } catch (e) {
        paraPharmaCatalogData!.isLiked = true;
        emit(ParaPharmaDetailsLoaded());
        GlobalExceptionHandler.handle(exception: e);
        return true;
      }
    }
    return false;
  }

  void shareProduct() async {
    if (paraPharmaCatalogData != null) {
      try {
        final product = paraPharmaCatalogData!;

        final deepLinkUrl =
            'https://hader-pharm.com/product/parapharma/${product.id}';

        await SharePlus.instance
            .share(ShareParams(uri: Uri.parse(deepLinkUrl)));
      } catch (e) {
        GlobalExceptionHandler.handle(exception: e);
      }
    }
  }

  void changeTapIndex(int index) {
    currentTapIndex = index;
    emit(ParaPharmaDetailsTapIndexChanged());
  }

  void incrementQuantity() {
    final updatedQuantity = int.parse(quantityController.text) + 1;
    quantityController.text = (updatedQuantity).toString();

    packageQuantityController.text =
        (updatedQuantity ~/ (paraPharmaCatalogData?.packageSize ?? 1))
            .toString();
    emit(ParaPharmaQuantityChanged());
  }

  void decrementQuantity() {
    final updatedQuantity = int.parse(quantityController.text) - 1;
    if (updatedQuantity > 0) {
      quantityController.text = (updatedQuantity).toString();

      packageQuantityController.text =
          (updatedQuantity ~/ (paraPharmaCatalogData?.packageSize ?? 1))
              .toString();
    }
    emit(ParaPharmaQuantityChanged());
  }

  void incrementPackageQuantity() {
    final currPackageQuantity = int.parse(packageQuantityController.text) + 1;

    packageQuantityController.text = currPackageQuantity.toString();
    quantityController.text =
        (currPackageQuantity * (paraPharmaCatalogData?.packageSize ?? 1))
            .toString();
    emit(ParaPharmaQuantityChanged());
  }

  void decrementPackageQuantity() {
    final currPackageQuantity = int.parse(packageQuantityController.text) - 1;

    final updatedItemQuantity =
        (currPackageQuantity * (paraPharmaCatalogData?.packageSize ?? 1));

    packageQuantityController.text =
        (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    quantityController.text =
        (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(ParaPharmaQuantityChanged());
  }

  Future<bool> passQuickOrder() async {
    if (!(shippingAddressKey.currentState?.validate() ?? false)) {
      return false;
    }
    try {
      emit(PassingQuickOrder());
      await ordersRepository.createQuickOrder(
          orderDetails: CreateQuickOrderModel(
        deliveryAddress: shippingAddressKey.currentState!.value,
        deliveryTownId: getItInstance.get<UserManager>().currentUser.townId,
        paraPharmaCatalogId: paraPharmaCatalogData!.id,
        qty: int.parse(quantityController.text),
      ));
      emit(QuickOrderPassed());
      return true;
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(PassQuickOrderFailed());
      return false;
    }
  }

  void refreshUi() {
    emit(ParaPharmaDetailsLoaded());
  }

  void updateQuantityPackage(String v) {
    final currPackageQuantity = int.parse(v);

    final updatedItemQuantity =
        (currPackageQuantity * (paraPharmaCatalogData?.packageSize ?? 1));

    packageQuantityController.text =
        (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    quantityController.text =
        (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(ParaPharmaQuantityChanged());
  }

  void updateQuantity(String v) {
    final updatedQuantity = int.parse(v);
    if (updatedQuantity > 0) {
      quantityController.text = (updatedQuantity).toString();

      packageQuantityController.text =
          (updatedQuantity ~/ (paraPharmaCatalogData?.packageSize ?? 1))
              .toString();
    }
    emit(ParaPharmaQuantityChanged());
  }
}
