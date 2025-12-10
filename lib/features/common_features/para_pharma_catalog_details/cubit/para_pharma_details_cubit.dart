import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/deeplinks/deeplinks_service.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/enums.dart'
    show InvoiceTypes, PaymentMethods;
import 'package:share_plus/share_plus.dart';

part 'para_pharma_details_state.dart';

class ParaPharmaDetailsCubit extends Cubit<ParaPharmaDetailsState> {
  final GlobalKey<FormFieldState<dynamic>> shippingAddressKey = GlobalKey();

  final ParaPharmaRepository paraPharmaCatalogRepository;

  final OrderRepository ordersRepository;
  final FavoriteRepository favoriteRepository;

  final String? buyerCompanyId;

  ParaPharmaDetailsCubit(
      {required TextEditingController quantityController,
      required TextEditingController packageQuantityController,
      required this.paraPharmaCatalogRepository,
      required TabController tabController,
      required this.favoriteRepository,
      this.buyerCompanyId,
      required this.ordersRepository})
      : super(ParaPharmaDetailsInitial(
          tabController: tabController,
          quantityController: quantityController,
          packageQuantityController: packageQuantityController,
        ));

  Future<void> getParaPharmaCatalogData(String id) async {
    try {
      emit(state.toLoading());
      final paraPharmaCatalogData =
          await paraPharmaCatalogRepository.getParaPharmaCatalogById(id,buyerCompanyId);
      state.quantityController.text =
          paraPharmaCatalogData.minOrderQuantity.toString();
      emit(state.toLoaded(data: paraPharmaCatalogData));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.toLoadError());
    }
  }

  void setupParapharmCatalogData(ParaPharmaCatalogModel paraPharmaCatalogData) {
    emit(state.toLoaded(data: paraPharmaCatalogData));
  }

  Future<bool> likeParaPharma() async {
    if (state.paraPharmaCatalogData.id.isNotEmpty) {
      try {
        await favoriteRepository.likeParaPharmaCatalog(
            paraPharmaCatalogId: state.paraPharmaCatalogData.id);

        emit(state.toLoaded(
            data: state.paraPharmaCatalogData.copyWith(
          isLiked: true,
        )));

        return true;
      } catch (e) {
        emit(state.toLoadError());
        GlobalExceptionHandler.handle(exception: e);
        return false;
      }
    }
    return false;
  }

  Future<bool> unlikeParaPharma() async {
    if (state.paraPharmaCatalogData.id.isNotEmpty) {
      try {
        await favoriteRepository.unLikeParaPharmaCatalog(
            paraPharmaCatalogId: state.paraPharmaCatalogData.id);

        emit(
          state.toLoaded(
            data: state.paraPharmaCatalogData.copyWith(
              isLiked: false,
            ),
          ),
        );
        return false;
      } catch (e) {
        emit(state.toLoadError());
        GlobalExceptionHandler.handle(exception: e);
        return true;
      }
    }
    return false;
  }

  void shareProduct() async {
    if (state.paraPharmaCatalogData.id.isNotEmpty) {
      try {
        final product = state.paraPharmaCatalogData;

        final deepLinkUrl =
            '${DeeplinksService.scheme}://${DeeplinksService.host}/product/parapharma/${product.id}';

        await SharePlus.instance
            .share(ShareParams(uri: Uri.parse(deepLinkUrl)));
      } catch (e) {
        GlobalExceptionHandler.handle(exception: e);
      }
    }
  }

  void changeTapIndex(int index) {
    emit(state.toTapIndexChanged(index: index));
  }

  void incrementQuantity() {
    try {
      final updatedQuantity = int.parse(state.quantityController.text) + 1;
      state.quantityController.text = (updatedQuantity).toString();

      state.packageQuantityController.text =
          (updatedQuantity ~/ (state.paraPharmaCatalogData.packageSize))
              .toString();
      emit(state.toQuantityChanged());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  void decrementQuantity() {
    try {
      final updatedQuantity = int.parse(state.quantityController.text) - 1;
      if (updatedQuantity > 0) {
        state.quantityController.text = (updatedQuantity).toString();

        state.packageQuantityController.text =
            (updatedQuantity ~/ (state.paraPharmaCatalogData.packageSize))
                .toString();
      }
      emit(state.toQuantityChanged());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  void incrementPackageQuantity() {
    final currPackageQuantity =
        int.parse(state.packageQuantityController.text) + 1;

    state.packageQuantityController.text = currPackageQuantity.toString();
    state.quantityController.text =
        (currPackageQuantity * (state.paraPharmaCatalogData.packageSize))
            .toString();
    emit(state.toQuantityChanged());
  }

  void decrementPackageQuantity() {
    final currPackageQuantity =
        int.parse(state.packageQuantityController.text) - 1;

    final updatedItemQuantity =
        (currPackageQuantity * (state.paraPharmaCatalogData.packageSize));

    state.packageQuantityController.text =
        (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    state.quantityController.text =
        (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(state.toQuantityChanged());
  }

  Future<bool> passQuickOrder() async {
    if (!(shippingAddressKey.currentState?.validate() ?? false)) {
      return false;
    }
    try {
      emit(state.toPassingQuickOrder(
          state.selectedPaymentMethod, state.selectedInvoiceType));
      await ordersRepository.createQuickOrder(
          orderDetails: CreateQuickOrderModel(
        deliveryAddress: shippingAddressKey.currentState!.value,
        deliveryTownId: getItInstance.get<UserManager>().currentUser.townId,
        paraPharmaCatalogId: state.paraPharmaCatalogData.id,
        qty: int.parse(state.quantityController.text),
        paymentMethod: state.selectedPaymentMethod ?? PaymentMethods.cash,
        invoiceType: state.selectedInvoiceType ?? InvoiceTypes.facture,
      ));
      emit(state.toQuickOrderPassed());
      return true;
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toPassQuickOrderFailed());
      return false;
    }
  }

  void refreshUi() {
    emit(state.toLoaded(data: state.paraPharmaCatalogData));
  }

  void updateQuantityPackage(String v) {
    final currPackageQuantity = int.parse(v);

    final updatedItemQuantity =
        (currPackageQuantity * (state.paraPharmaCatalogData.packageSize));

    state.packageQuantityController.text =
        (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    state.quantityController.text =
        (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(state.toQuantityChanged());
  }

  void changeInvoiceMethod(InvoiceTypes invoiceType) {
    emit(state.toOrderPramsChanged(state.selectedPaymentMethod, invoiceType));
  }

  void changePaymentMethod(PaymentMethods paymentMethod) {
    emit(state.toOrderPramsChanged(paymentMethod, state.selectedInvoiceType));
  }

  void updateQuantity(String v) {
    final updatedQuantity = int.parse(v.isEmpty ? '0' : v);
    if (updatedQuantity > 0) {
      state.quantityController.text = (updatedQuantity).toString();

      state.packageQuantityController.text =
          (updatedQuantity ~/ (state.paraPharmaCatalogData.packageSize))
              .toString();
    }
    emit(state.toQuantityChanged());
  }
}
