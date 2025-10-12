import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/params/load_announcement_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
part 'annoncement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  final searchController = TextEditingController();
  String announcementId;
  final FavoriteRepository favoriteRepository;
  final ScrollController scrollController;
  late final IPromotionRepository _promotionRepository;

  Company? vendor;
  List<MedicineCatalogModel> medicines = [];
  List<ParaPharmaCatalogModel> paraPharmas = [];
  AnnouncementModel? announcement;


  AnnouncementCubit(
      {required this.announcementId,
      required this.favoriteRepository,
      required this.scrollController,

      required IPromotionRepository promotionRepository})
      : super(AnnouncementStateInitial()) {
    _promotionRepository = promotionRepository;
  }


  Future<void> loadAnnouncement() async {
    try {
      emit(AnnouncementIsLoading());

      final data = await _promotionRepository.getPromotion(ParamsLoadAnnouncementDetails(id:announcementId));

      announcement = data.announcement;

      vendor = data.company;
      medicines = data.medicines;
      paraPharmas = data.parapharmas;

      emit(AnnouncementLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(AnnouncementLoadingError());
    }
  }

  void goToPromotionPage() {
    _pageIndex = 0;
    emit(AnnouncementPageChanged());
  }

  void goToMedicinePage() {
    _pageIndex = 1;
    emit(AnnouncementPageChanged());
  }

  void goToParaPharmaPage() {
    _pageIndex = 2;
    emit(AnnouncementPageChanged());
  }

 

  Future<void> likeMedicinesCatalog(String medicineCatalogId) async {
    var index = medicines
        .lastIndexWhere((medicine) => medicine.id == medicineCatalogId);
    try {
      medicines[index].isLiked = true;
      await favoriteRepository.likeMedicineCatalog(
          medicineCatalogId: medicineCatalogId);

      emit(MedicineLiked(medicineId: medicineCatalogId));
    } catch (e) {
      medicines[index].isLiked = false;
      GlobalExceptionHandler.handle(exception: e);
      emit(MedicineLikeFailed(medicineId: medicineCatalogId));
    }
  }

  Future<void> unlikeMedicinesCatalog(String medicineCatalogId) async {
    var index = medicines
        .lastIndexWhere((medicine) => medicine.id == medicineCatalogId);
    try {
      medicines[index].isLiked = false;
      await favoriteRepository.unLikeMedicineCatalog(
          medicineCatalogId: medicineCatalogId);
      emit(MedicineLiked(medicineId: medicineCatalogId));
    } catch (e) {
      medicines[index].isLiked = true;
      GlobalExceptionHandler.handle(exception: e);
      emit(MedicineLikeFailed(medicineId: medicineCatalogId));
    }
  }

  
  Future<void> likeParaPharmaCatalog(String paraPharmaCatalogId) async {
    var index = paraPharmas.lastIndexWhere((paraProd) => paraProd.id == paraPharmaCatalogId);
    try {
      paraPharmas[index].isLiked = true;
      await favoriteRepository.likeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaCatalogId);

      emit(ParapharmaLiked(paraPharmaId: paraPharmaCatalogId));
    } catch (e) {
      paraPharmas[index].isLiked = false;
      GlobalExceptionHandler.handle(exception: e);
      emit(ParaPharmaLikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  Future<void> unlikeParaPharmaCatalog(String paraPharmaCatalogId) async {
    var index = paraPharmas.lastIndexWhere((paraProd) => paraProd.id == paraPharmaCatalogId);
    try {
      paraPharmas[index].isLiked = false;
      await favoriteRepository.unLikeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaCatalogId);
      emit(ParapharmaLiked(paraPharmaId: paraPharmaCatalogId));
    } catch (e) {
      paraPharmas[index].isLiked = true;
      GlobalExceptionHandler.handle(exception: e);
      emit(ParaPharmaLikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }



 
}
