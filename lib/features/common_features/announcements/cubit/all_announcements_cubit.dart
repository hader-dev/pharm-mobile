import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';

part 'all_announcements_state.dart';

class AllAnnouncementsCubit extends Cubit<AllAnnouncementsState> {
  int totalItemsCount = 0;
  int offSet = 0;
  List<AnnouncementModel> announcements = [];
  String? companyId;

  final PromotionRepository announcementsRepo;
  final ScrollController scrollController;
  int limit = 20;

  AllAnnouncementsCubit(
      {required this.announcementsRepo,
      required this.scrollController,
      this.companyId})
      : super(const AllAnnouncementsInitial()) {
    _onScroll();
  }

  Future<void> getAnnouncements({int offset = 0}) async {
    try {
      emit(AllAnnouncementsLoading(
          announcements: announcements, hasReachedMax: false));

      final response = await announcementsRepo.getPromotions(
          limit: limit, companyId: companyId);
      totalItemsCount = response.totalItems;
      announcements = response.announcements;

      emit(AllAnnouncementsLoaded(
        announcements: announcements,
        hasReachedMax: announcements.length >= totalItemsCount,
      ));
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      debugPrint("Error loading announcements: $e");
      emit(AllAnnouncementsLoadingFailed(
        announcements: announcements,
        hasReachedMax: false,
        message: "Failed to load announcements",
      ));
    }
  }

  Future<void> loadMoreAnnouncements() async {
    try {
      if (offSet >= totalItemsCount) {
        emit(AnnouncementsLoadLimitReached(
            announcements: announcements, hasReachedMax: true));
        return;
      }

      offSet = offSet + limit;
      emit(AllAnnouncementsLoading(
          announcements: announcements, hasReachedMax: false));

      final response = await announcementsRepo.getPromotions(
          limit: limit, offset: offSet, companyId: companyId);
      totalItemsCount = response.totalItems;
      announcements.addAll(response.announcements);

      emit(AllAnnouncementsLoaded(
        announcements: announcements,
        hasReachedMax: announcements.length >= totalItemsCount,
      ));
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      debugPrint("Error loading more announcements: $e");
      emit(AllAnnouncementsLoadingFailed(
        announcements: announcements,
        hasReachedMax: false,
        message: "Failed to load more announcements",
      ));
    }
  }

  Future<void> refreshAnnouncements() async {
    offSet = 0;
    announcements.clear();
    await getAnnouncements();
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (offSet < totalItemsCount) {
          await loadMoreAnnouncements();
        } else {
          emit(AnnouncementsLoadLimitReached(
              announcements: announcements, hasReachedMax: true));
        }
      }
    });
  }
}
