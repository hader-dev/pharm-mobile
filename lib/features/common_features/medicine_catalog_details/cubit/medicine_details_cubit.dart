import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../models/medicine_catalog.dart';
import '../../../../repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';

part 'medicine_details_state.dart';

class MedicineDetailsCubit extends Cubit<MedicineDetailsState> {
  MedicineCatalogModel? medicineCatalogData;
  int currentTapIndex = 0;
  final MedicineCatalogRepository medicineCatalogRepository;
  final TabController tabController;

  MedicineDetailsCubit({required this.medicineCatalogRepository, required this.tabController})
      : super(MedicineDetailsInitial());
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
}
