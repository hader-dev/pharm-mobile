import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
part 'para_pharma_details_state.dart';

class ParaPharmaDetailsCubit extends Cubit<ParaPharmaDetailsState> {
  ParaPharmaCatalogModel? paraPharmaCatalogData;
  int currentTapIndex = 0;
  final ParaPharmaRepository paraPharmaCatalogRepository;
  final TabController tabController;
  final OrderRepository ordersRepository;
  final FavoriteRepository favoriteRepository;

  final TextEditingController quantityController;

  ParaPharmaDetailsCubit(
      {required this.quantityController,
      required this.paraPharmaCatalogRepository,
      required this.tabController,
      required this.favoriteRepository,
      required this.ordersRepository})
      : super(ParaPharmaDetailsInitial());
  getParaPharmaCatalogData(String id) async {
    try {
      emit(ParaPharmaDetailsLoading());
      paraPharmaCatalogData =
          await paraPharmaCatalogRepository.getParaPharmaCatalogById(id);
      emit(ParaPharmaDetailsLoaded());
    } catch (e) {
      emit(ParaPharmaDetailsLoadError());
    }
  }
  Future<void> likeParaPharma() async {
  if (paraPharmaCatalogData != null) {
    try {
      paraPharmaCatalogData!.isLiked = true;
      emit(ParaPharmaDetailsLoaded());
      await favoriteRepository.likeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaCatalogData!.id);
    } catch (e) {
      paraPharmaCatalogData!.isLiked = false;
      emit(ParaPharmaDetailsLoaded());
      GlobalExceptionHandler.handle(exception: e);
    }
  }
}

Future<void> unlikeParaPharma() async {
  if (paraPharmaCatalogData != null) {
    try {
      paraPharmaCatalogData!.isLiked = false;
      emit(ParaPharmaDetailsLoaded());
      await favoriteRepository.unLikeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaCatalogData!.id);
    } catch (e) {
      paraPharmaCatalogData!.isLiked = true;
      emit(ParaPharmaDetailsLoaded());
      GlobalExceptionHandler.handle(exception: e);
    }
  }
}

  void changeTapIndex(int index) {
    currentTapIndex = index;
    emit(ParaPharmaDetailsTapIndexChanged());
  }

  void incrementQuantity() {
    quantityController.text =
        (int.parse(quantityController.text) + 1).toString();
    emit(ParaPharmaQuantityChanged());
  }

  void decrementQuantity() {
    if (int.parse(quantityController.text) > 1) {
      quantityController.text =
          (int.parse(quantityController.text) - 1).toString();
    }
    emit(ParaPharmaQuantityChanged());
  }

  void passQuickOrder() async {
    try {
      emit(PassingQuickOrder());
      await ordersRepository.createQuickOrder(
          orderDetails: CreateQuickOrderModel(
        deliveryAddress: 'alger,alger',
        deliveryTownId: 10,
        paraPharmaCatalogId: paraPharmaCatalogData!.id,
        qty: int.parse(quantityController.text),
      ));
      emit(QuickOrderPassed());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(PassQuickOrderFailed());
    }
  }
}
