import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  List<BaseMedicineCatalogModel> likedMedicinesCatalogs = [];
  List<BaseParaPharmaCatalogModel> likedParaPharmaCatalogs = [];
  List<Company> likedVendors = [];
  FavoriteRepository favoriteRepository;
  FavoritesCubit({required this.favoriteRepository})
      : super(FavoritesInitial());

  fetchFavorites() async {
    await Future.wait(
        [fetchLikedMedicines(), fetchLikedParaPharma(), fetchLikedVendors()]);
  }

  Future<void> fetchLikedMedicines() async {
    try {
      emit(FavoritesMedicinesLoading());
      likedMedicinesCatalogs =
          await favoriteRepository.getFavoritesMedicinesCatalogs();
      emit(FavoritesMedicinesLoaded());
    } catch (e) {
      // debugPrintStack(stackTrace: stackTrace);
      // debugPrint("$e");
      GlobalExceptionHandler.handle(exception: e);
      emit(FavoritesMedicinesLoadingFailed());
    }
  }

  Future<void> fetchLikedParaPharma() async {
    try {
      emit(FavoritesParaPharmaLoading());
      likedParaPharmaCatalogs =
          await favoriteRepository.getFavoritesParaPharmasCatalogs();
      emit(FavoritesParaPharmaLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(FavoritesParaPharmaLoadingFailed());
    }
  }

  Future<void> fetchLikedVendors() async {
    try {
      emit(FavoritesVendorsLoading());
      likedVendors = await favoriteRepository.getFavoritesVendors();
      emit(FavoritesVendorsLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(FavoritesVendorsLoadingFailed());
    }
  }

  void removeFromFavoritesMedicines(String medicineId) {
    likedMedicinesCatalogs.removeWhere((medicine) => medicine.id == medicineId);
    favoriteRepository.unLikeMedicineCatalog(medicineCatalogId: medicineId);
    emit(FavoritesMedicinesLoaded());
  }

  void removeParaPharmaFromFavorites(String paraPharmaId) {
    likedParaPharmaCatalogs
        .removeWhere((paraPharma) => paraPharma.id == paraPharmaId);
    favoriteRepository.unLikeParaPharmaCatalog(
        paraPharmaCatalogId: paraPharmaId);
    emit(FavoritesParaPharmaLoaded());
  }

  void removeFromFavoritesVendors(String vendorId) {
    likedVendors.removeWhere((vendor) => vendor.id == vendorId);
    favoriteRepository.unLikeVendors(vendorId: vendorId);
    emit(FavoritesVendorsLoaded());
  }
}
