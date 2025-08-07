import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';


part 'medicine_details_state.dart';

class MedicineDetailsCubit extends Cubit<MedicineDetailsState> {
  MedicineCatalogModel? medicineCatalogData;
  int currentTapIndex = 0;
  String shippingAddress = "";
  final TextEditingController quantityController;

  final MedicineCatalogRepository medicineCatalogRepository;
  final OrderRepository ordersRepository;
  final FavoriteRepository favoriteRepository;
  final TabController tabController;

  MedicineDetailsCubit(
      {required this.medicineCatalogRepository,
      required this.quantityController,
      required this.tabController,
      required this.ordersRepository,
      required this.favoriteRepository})
      : super(MedicineDetailsInitial()) {
    quantityController.addListener(() {
      if (int.parse(quantityController.text) <= 0) {
        quantityController.text = '1';
      }
    });
  }
  Future<void> likeMedicine() async {
    if(medicineCatalogData== null) return;
    try {
      medicineCatalogData!.isLiked = true;
      emit(MedicineDetailsLoaded());
      await favoriteRepository.likeMedicineCatalog(medicineCatalogId: medicineCatalogData!.id);
    } catch (e) {
      medicineCatalogData!.isLiked = false;
      emit(MedicineDetailsLoaded());
      GlobalExceptionHandler.handle(exception: e);

    }
  }
     Future<void> unlikeMedicine() async {
  if (medicineCatalogData != null) {
    try {
      medicineCatalogData!.isLiked = false;
      emit(MedicineDetailsLoaded());
      await favoriteRepository.unLikeMedicineCatalog(medicineCatalogId: medicineCatalogData!.id);
    } catch (e) {
      medicineCatalogData!.isLiked = true;
      emit(MedicineDetailsLoaded());
      GlobalExceptionHandler.handle(exception: e);
    }
  }
}
   
  
  getMedicineCatalogData(String id) async {
    try {
      emit(MedicineDetailsLoading());
      medicineCatalogData = await medicineCatalogRepository.getMedicineCatalogById(id);
      emit(MedicineDetailsLoaded());
    } catch (e) {
      emit(MedicineDetailsLoadError());
    }
  }

  void changeTapIndex(int index) {
    currentTapIndex = index;
    emit(MedicineDetailsTapIndexChanged());
  }

  void incrementQuantity() {
    quantityController.text = (int.parse(quantityController.text) + 1).toString();
    emit(MedicineQuantityChanged());
  }

  void decrementQuantity() {
    if (int.parse(quantityController.text) > 1) {
      quantityController.text = (int.parse(quantityController.text) - 1).toString();
    }
    emit(MedicineQuantityChanged());
  }

  void passQuickOrder() async {
    try {
      emit(PassingQuickOrder());
      await ordersRepository.createQuickOrder(
          orderDetails: CreateQuickOrderModel(
        deliveryAddress: shippingAddress,
        deliveryTownId: 10,
        medicineCatalogId: medicineCatalogData!.id,
        qty: int.parse(quantityController.text),
      ));
      emit(QuickOrderPassed());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(PassQuickOrderFailed());
    }
  }

  void updateShippingAddress(String value) {
    shippingAddress = value;
  }
  // Timer? _debounce;

  // void onChangeQuantity() {
  //   if (_debounce?.isActive ?? false) _debounce!.cancel();

  //   _debounce = Timer(const Duration(seconds: 1), () {
  //     final value = quantityController.text.trim();
  //     if (value.isNotEmpty) {
  //       final quantity = int.tryParse(value);
  //       if (quantity != null && quantity > 0) {
  //         quantityController.text = quantity.toString();
  //         emit(QuantityChanged());
  //       } else {
  //         // Reset to 1 or any valid value you prefer
  //         quantityController.text = '1';
  //       }
  //     }
  //   });
  // }
}
