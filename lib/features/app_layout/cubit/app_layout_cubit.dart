import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'app_layout_state.dart';

class AppLayoutCubit extends Cubit<AppLayoutState> {
  int pageIndex = 0;

  List<Widget> screens = [];

  AppLayoutCubit() : super(AppLayoutInitial());

  void changePage(int index) {
    pageIndex = index;
    emit(PageChanged());
  }
}
