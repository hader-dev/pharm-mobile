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
  late final IPromotionRepository _promotionRepository;
  final FavoriteRepository favoriteRepository;

  AnnouncementCubit(
      {required String announcementId,
      required this.favoriteRepository,
      required ScrollController scrollController,
      required IPromotionRepository promotionRepository})
      : super(AnnouncementStateInitial(
          scrollController: scrollController,
          announcementId: announcementId,
        )) {
    _promotionRepository = promotionRepository;
  }

  Future<void> loadAnnouncement() async {
    try {
      emit(state.toLoading());

      final data = await _promotionRepository.getPromotion(
          ParamsLoadAnnouncementDetails(id: state.announcementId));

      emit(state.toLoaded(
        medicines: data.medicines,
        paraPharmas: data.parapharmas,
        announcement: data.announcement ?? AnnouncementModel.empty(),
        vendor: data.company ?? Company.empty(),
      ));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toError());
    }
  }

  void goToPromotionPage() {
    emit(state.toPageChanged(
      pageIndex: 0,
    ));
  }

  void goToMedicinePage() {
    emit(state.toPageChanged(
      pageIndex: 1,
    ));
  }

  void goToParaPharmaPage() {
    emit(state.toPageChanged(
      pageIndex: 2,
    ));
  }

  Future<void> likeMedicinesCatalog(MedicineCatalogModel medicine) async {
    try {
      final updatedItem = medicine.copyWith(isLiked: !medicine.isLiked);

      await favoriteRepository.likeMedicineCatalog(
          medicineCatalogId: updatedItem.id);

      emit(state.toLikeItem(updatedMedicine: updatedItem));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLikeItemFailed());
    }
  }

  Future<void> unlikeMedicinesCatalog(MedicineCatalogModel item) async {
    try {
      final updatedItem = item.copyWith(isLiked: false);

      await favoriteRepository.unLikeMedicineCatalog(
          medicineCatalogId: updatedItem.id);
      emit(state.toLikeItem(updatedMedicine: updatedItem));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLikeItemFailed());
    }
  }

  Future<void> likeParaPharmaCatalog(ParaPharmaCatalogModel item) async {
    try {
      final updatedItem = item.copyWith(isLiked: true);
      await favoriteRepository.likeParaPharmaCatalog(
          paraPharmaCatalogId: updatedItem.id);

      emit(state.toLikeItem(updatedParaPharma: updatedItem));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toError());
    }
  }

  Future<void> unlikeParaPharmaCatalog(ParaPharmaCatalogModel item) async {
    try {
      final updatedItem = item.copyWith(isLiked: false);
      await favoriteRepository.unLikeParaPharmaCatalog(
          paraPharmaCatalogId: updatedItem.id);
      emit(state.toLikeItem(updatedParaPharma: updatedItem));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toError());
    }
  }
}
