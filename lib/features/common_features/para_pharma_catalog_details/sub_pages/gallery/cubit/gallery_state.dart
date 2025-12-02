part of 'gallery_cubit.dart';

sealed class GalleryState {}

final class GalleryInitial extends GalleryState {}

final class SelectedGalleryChanged extends GalleryState {
  final int selectedGalleryIndex;
  SelectedGalleryChanged({this.selectedGalleryIndex = 0});
}
