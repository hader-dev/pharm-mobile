part of 'favorites_cubit.dart';

sealed class FavoritesState {
  final List<BaseMedicineCatalogModel> likedMedicinesCatalogs;
  final List<BaseParaPharmaCatalogModel> likedParaPharmaCatalogs;
  final List<Company> likedVendors;

  FavoritesState(
      {required this.likedMedicinesCatalogs,
      required this.likedParaPharmaCatalogs,
      required this.likedVendors});

  FavoritesMedicinesLoading toLoadingMedicines() =>
      FavoritesMedicinesLoading.fromState(state: this);

  FavoritesMedicinesLoaded toLoadedMedicines({
    required List<BaseMedicineCatalogModel> medicines,
  }) =>
      FavoritesMedicinesLoaded.fromState(state: this, medicines: medicines);

  FavoritesMedicinesLoadingFailed toLoadingMedicinesFailed() =>
      FavoritesMedicinesLoadingFailed.fromState(state: this);

  FavoritesParaPharmaLoading toLoadingParaPharma() =>
      FavoritesParaPharmaLoading.fromState(state: this);

  FavoritesParaPharmaLoaded toLoadedParaPharma({
    required List<BaseParaPharmaCatalogModel> paraPharmas,
  }) =>
      FavoritesParaPharmaLoaded.fromState(
          state: this, paraPharmas: paraPharmas);

  FavoritesParaPharmaLoadingFailed toLoadingParaPharmaFailed() =>
      FavoritesParaPharmaLoadingFailed.fromState(state: this);

  FavoritesVendorsLoading toLoadingVendors() =>
      FavoritesVendorsLoading.fromState(state: this);

  FavoritesVendorsLoaded toLoadedVendors({
    required List<Company> vendors,
  }) =>
      FavoritesVendorsLoaded.fromState(state: this, vendors: vendors);

  FavoritesVendorsLoadingFailed toLoadingVendorsFailed() =>
      FavoritesVendorsLoadingFailed.fromState(state: this);
}

final class FavoritesInitial extends FavoritesState {
  FavoritesInitial(
      {super.likedMedicinesCatalogs = const [],
      super.likedParaPharmaCatalogs = const [],
      super.likedVendors = const []});
}

//Medicines
final class FavoritesMedicinesLoading extends FavoritesInitial {
  FavoritesMedicinesLoading.fromState({required FavoritesState state})
      : super(
            likedMedicinesCatalogs: state.likedMedicinesCatalogs,
            likedParaPharmaCatalogs: state.likedParaPharmaCatalogs,
            likedVendors: state.likedVendors);
}

final class FavoritesMedicinesLoaded extends FavoritesInitial {
  FavoritesMedicinesLoaded.fromState(
      {required FavoritesState state,
      required List<BaseMedicineCatalogModel> medicines})
      : super(
            likedMedicinesCatalogs: medicines,
            likedParaPharmaCatalogs: state.likedParaPharmaCatalogs,
            likedVendors: state.likedVendors);
}

final class FavoritesMedicinesLoadingFailed extends FavoritesInitial {
  FavoritesMedicinesLoadingFailed.fromState({required FavoritesState state})
      : super(
            likedMedicinesCatalogs: state.likedMedicinesCatalogs,
            likedParaPharmaCatalogs: state.likedParaPharmaCatalogs,
            likedVendors: state.likedVendors);
}

//Para-pharma
final class FavoritesParaPharmaLoading extends FavoritesInitial {
  FavoritesParaPharmaLoading.fromState({required FavoritesState state})
      : super(
            likedMedicinesCatalogs: state.likedMedicinesCatalogs,
            likedParaPharmaCatalogs: state.likedParaPharmaCatalogs,
            likedVendors: state.likedVendors);
}

final class FavoritesParaPharmaLoaded extends FavoritesInitial {
  FavoritesParaPharmaLoaded.fromState(
      {required FavoritesState state,
      required List<BaseParaPharmaCatalogModel> paraPharmas})
      : super(
            likedMedicinesCatalogs: state.likedMedicinesCatalogs,
            likedParaPharmaCatalogs: paraPharmas,
            likedVendors: state.likedVendors);
}

final class FavoritesParaPharmaLoadingFailed extends FavoritesInitial {
  FavoritesParaPharmaLoadingFailed.fromState({required FavoritesState state})
      : super(
            likedMedicinesCatalogs: state.likedMedicinesCatalogs,
            likedParaPharmaCatalogs: state.likedParaPharmaCatalogs,
            likedVendors: state.likedVendors);
}

// Vendors
final class FavoritesVendorsLoading extends FavoritesInitial {
  FavoritesVendorsLoading.fromState({required FavoritesState state})
      : super(
            likedMedicinesCatalogs: state.likedMedicinesCatalogs,
            likedParaPharmaCatalogs: state.likedParaPharmaCatalogs,
            likedVendors: state.likedVendors);
}

final class FavoritesVendorsLoaded extends FavoritesInitial {
  FavoritesVendorsLoaded.fromState(
      {required FavoritesState state, required List<Company> vendors})
      : super(
            likedMedicinesCatalogs: state.likedMedicinesCatalogs,
            likedParaPharmaCatalogs: state.likedParaPharmaCatalogs,
            likedVendors: vendors);
}

final class FavoritesVendorsLoadingFailed extends FavoritesInitial {
  FavoritesVendorsLoadingFailed.fromState({required FavoritesState state})
      : super(
            likedMedicinesCatalogs: state.likedMedicinesCatalogs,
            likedParaPharmaCatalogs: state.likedParaPharmaCatalogs,
            likedVendors: state.likedVendors);
}
