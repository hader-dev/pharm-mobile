import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../models/medicine_catalog.dart';
import '../../../../repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';

part 'medicine_details_state.dart';

class MedicineDetailsCubit extends Cubit<MedicineDetailsState> {
  MedicineCatalogModel? medicineCatalogData;
  int currentTapIndex = 0;
  final TextEditingController quantityController;

  final MedicineCatalogRepository medicineCatalogRepository;
  final TabController tabController;

  MedicineDetailsCubit(
      {required this.medicineCatalogRepository, required this.quantityController, required this.tabController})
      : super(MedicineDetailsInitial()) {
    quantityController.addListener(() {
      if (int.parse(quantityController.text) <= 0) {
        quantityController.text = '1';
      }
    });
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
