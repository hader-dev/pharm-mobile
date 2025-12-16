import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoriteRepository favoriteRepository;
  FavoritesCubit({required this.favoriteRepository}) : super(FavoritesInitial());

  void fetchFavorites() async {
    await Future.wait([fetchLikedMedicines(), fetchLikedParaPharma(), fetchLikedVendors()]);
  }

  Future<void> fetchLikedMedicines() async {
    try {
      emit(state.toLoadingMedicines());

      final likedMedicinesCatalogs = await favoriteRepository.getFavoritesMedicinesCatalogs();
      emit(state.toLoadedMedicines(
        medicines: likedMedicinesCatalogs,
      ));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLoadingMedicinesFailed());
    }
  }

  Future<void> fetchLikedParaPharma() async {
    try {
      emit(state.toLoadingParaPharma());
      final likedParaPharmaCatalogs = await favoriteRepository.getFavoritesParaPharmasCatalogs();
      emit(state.toLoadedParaPharma(
        paraPharmas: likedParaPharmaCatalogs,
      ));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLoadingParaPharmaFailed());
    }
  }

  Future<void> fetchLikedVendors() async {
    try {
      emit(state.toLoadingVendors());
      final likedVendors = await favoriteRepository.getFavoritesVendors();
      emit(state.toLoadedVendors(
        vendors: likedVendors,
      ));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLoadingVendorsFailed());
    }
  }

  void unlikeMedicine(String medicineId) {
    final medicines = state.likedMedicinesCatalogs.toList();
    medicines.removeWhere((medicine) => medicine.id == medicineId);

    favoriteRepository.unLikeMedicineCatalog(medicineCatalogId: medicineId);
    emit(state.toLoadedMedicines(
      medicines: medicines,
    ));
  }

  Future<void> likeMedicine(String medicineId) async {
    favoriteRepository.likeMedicineCatalog(medicineCatalogId: medicineId);
  }

  void unlikeParaPharma(String paraPharmaId) {
    final parapharmas = state.likedParaPharmaCatalogs.toList();
    parapharmas.removeWhere((paraPharma) => paraPharma.id == paraPharmaId);
    favoriteRepository.unLikeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaId);
    emit(state.toLoadedParaPharma(paraPharmas: parapharmas));
  }

  Future<void> likeParaPharmaCatalog(String paraPharmaCatalogId) async {
    favoriteRepository.likeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaCatalogId);
  }

  void unlikeVendor(String vendorId) {
    final vendors = state.likedVendors.toList();
    vendors.removeWhere((vendor) => vendor.id == vendorId);
    favoriteRepository.unLikeVendors(vendorId: vendorId);
    emit(state.toLoadedVendors(
      vendors: vendors,
    ));
  }

  Future<void> likeVendor(String vendorId) async {
    favoriteRepository.likeVendors(vendorId: vendorId);
  }
}
