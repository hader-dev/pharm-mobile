import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show PageController;

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  int selectedGalleryIndex = 0;
  final PageController pageController = PageController(initialPage: 0);
  GalleryCubit() : super(GalleryInitial());

  void changeSelectedGallery(int index) {
    selectedGalleryIndex = index;
    pageController.jumpToPage(
      index,
    );
    emit(SelectedGalleryChanged(selectedGalleryIndex: selectedGalleryIndex));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
