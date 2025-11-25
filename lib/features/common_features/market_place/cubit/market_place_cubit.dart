import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show TabController;

part 'market_place_state.dart';

class MarketPlaceCubit extends Cubit<MarketPlaceState> {
  MarketPlaceCubit() : super(MarketPlaceInitial());

  void changeTab(int index, TabController tabController) {
    tabController.index = index;
    emit(MarketPlaceTapIndexChanged(pageIndex: index));
  }
}
