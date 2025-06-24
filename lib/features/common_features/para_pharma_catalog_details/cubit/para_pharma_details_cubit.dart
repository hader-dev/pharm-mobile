import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

import '../../../../repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

part 'para_pharma_details_state.dart';

class ParaPharmaDetailsCubit extends Cubit<ParaPharmaDetailsState> {
  ParaPharmaCatalogModel? paraPharmaCatalogData;
  int currentTapIndex = 0;
  final ParaPharmaRepository paraPharmaCatalogRepository;
  final TabController tabController;

  ParaPharmaDetailsCubit({required this.paraPharmaCatalogRepository, required this.tabController})
      : super(ParaPharmaDetailsInitial());
  getParaPharmaCatalogData(String id) async {
    try {
      emit(ParaPharmaDetailsLoading());
      paraPharmaCatalogData = await paraPharmaCatalogRepository.getParaPharmaCatalogById(id);
      emit(ParaPharmaDetailsLoaded());
    } catch (e) {
      emit(ParaPharmaDetailsLoadError());
    }
  }

  void changeTapIndex(int index) {
    currentTapIndex = index;
    emit(ParaPharmaDetailsTapIndexChanged());
  }
}
