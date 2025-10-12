part of 'announcement_cubit.dart';

class AnnouncementState {
  final int pageIndex;
  final TextEditingController searchController;
  final String announcementId;
  final ScrollController scrollController;

  final Company vendor;
  final List<MedicineCatalogModel> medicines;
  final List<ParaPharmaCatalogModel> paraPharmas;
  final AnnouncementModel announcement;

  AnnouncementState(
      {required this.pageIndex,
      required this.searchController,
      required this.announcementId,
      required this.scrollController,
      required this.vendor,
      required this.medicines,
      required this.paraPharmas,
      required this.announcement});

  AnnouncementIsLoading toLoading() =>
      AnnouncementIsLoading.fromState(state: this);

  AnnouncementLoaded toLoaded(
          {required List<MedicineCatalogModel> medicines,
          required List<ParaPharmaCatalogModel> paraPharmas,
          required AnnouncementModel announcement,
          required Company vendor}) =>
      AnnouncementLoaded.fromState(
          state: this,
          medicines: medicines,
          vendor: vendor,
          paraPharmas: paraPharmas,
          announcement: announcement);

  AnnouncementLoadingError toError() =>
      AnnouncementLoadingError.fromState(state: this);

  AnnouncementPageChanged toPageChanged({required int pageIndex}) =>
      AnnouncementPageChanged.fromState(state: this, pageIndex: pageIndex);

  LikeItemFailed toLikeItemFailed() => LikeItemFailed.fromState(state: this);

  ItemsUpdated toLikeItem(
      {MedicineCatalogModel? updatedMedicine,
      ParaPharmaCatalogModel? updatedParaPharma}) {
    final isMedicine = updatedMedicine != null;

    if (isMedicine) {
      final updatedItems = medicines.map((item) {
        if (item.id == updatedMedicine.id) {
          return updatedMedicine;
        }
        return item;
      }).toList();
      return ItemsUpdated.fromState(state: this, medicines: updatedItems);
    }

    final updatedItems = paraPharmas.map((item) {
      if (item.id == updatedParaPharma!.id) {
        return updatedParaPharma;
      }
      return item;
    }).toList();

    return ItemsUpdated.fromState(state: this, parapharmas: updatedItems);
  }
}

final class AnnouncementStateInitial extends AnnouncementState {
  AnnouncementStateInitial(
      {super.pageIndex = 0,
      super.announcementId = '',
      Company? vendor,
      super.medicines = const [],
      super.paraPharmas = const [],
      AnnouncementModel? announcement,
      TextEditingController? searchController,
      ScrollController? scrollController})
      : super(
          scrollController: scrollController ?? ScrollController(),
          searchController: searchController ?? TextEditingController(),
          vendor: vendor ?? Company.empty(),
          announcement: announcement ?? AnnouncementModel.empty(),
        );
}

final class AnnouncementIsLoading extends AnnouncementStateInitial {
  AnnouncementIsLoading.fromState({required AnnouncementState state})
      : super(
            pageIndex: state.pageIndex,
            announcementId: state.announcementId,
            searchController: state.searchController,
            scrollController: state.scrollController,
            vendor: state.vendor,
            medicines: state.medicines,
            paraPharmas: state.paraPharmas,
            announcement: state.announcement);
}

final class AnnouncementLoaded extends AnnouncementStateInitial {
  AnnouncementLoaded.fromState(
      {required AnnouncementState state,
      required super.medicines,
      required super.paraPharmas,
      required super.vendor,
      required super.announcement})
      : super(
          pageIndex: state.pageIndex,
          announcementId: state.announcementId,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class AnnouncementLoadingError extends AnnouncementStateInitial {
  AnnouncementLoadingError.fromState({required AnnouncementState state})
      : super(
            pageIndex: state.pageIndex,
            announcementId: state.announcementId,
            searchController: state.searchController,
            scrollController: state.scrollController,
            vendor: state.vendor,
            medicines: state.medicines,
            paraPharmas: state.paraPharmas,
            announcement: state.announcement);
}

final class AnnouncementPageChanged extends AnnouncementStateInitial {
  AnnouncementPageChanged.fromState(
      {required AnnouncementState state, required super.pageIndex})
      : super(
            announcementId: state.announcementId,
            searchController: state.searchController,
            scrollController: state.scrollController,
            vendor: state.vendor,
            medicines: state.medicines,
            paraPharmas: state.paraPharmas,
            announcement: state.announcement);
}

final class AnnouncementUpdated extends AnnouncementStateInitial {
  AnnouncementUpdated.fromState({required AnnouncementState state})
      : super(
            pageIndex: state.pageIndex,
            announcementId: state.announcementId,
            searchController: state.searchController,
            scrollController: state.scrollController,
            vendor: state.vendor,
            medicines: state.medicines,
            paraPharmas: state.paraPharmas,
            announcement: state.announcement);
}

final class ItemsUpdated extends AnnouncementStateInitial {
  ItemsUpdated.fromState({
    required AnnouncementState state,
    List<MedicineCatalogModel>? medicines,
    List<ParaPharmaCatalogModel>? parapharmas,
  }) : super(
            pageIndex: state.pageIndex,
            announcementId: state.announcementId,
            searchController: state.searchController,
            scrollController: state.scrollController,
            vendor: state.vendor,
            medicines: medicines ?? state.medicines,
            paraPharmas: parapharmas ?? state.paraPharmas,
            announcement: state.announcement);
}

final class LikeItemFailed extends AnnouncementStateInitial {
  LikeItemFailed.fromState({
    required AnnouncementState state,
  }) : super(
            pageIndex: state.pageIndex,
            announcementId: state.announcementId,
            searchController: state.searchController,
            scrollController: state.scrollController,
            vendor: state.vendor,
            medicines: state.medicines,
            paraPharmas: state.paraPharmas,
            announcement: state.announcement);
}
