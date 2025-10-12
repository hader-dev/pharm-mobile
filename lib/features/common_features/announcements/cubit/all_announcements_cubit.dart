import 'dart:async';

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
  String? currentSearchValue;

  final PromotionRepository announcementsRepo;
  final ScrollController scrollController;
  final TextEditingController searchController;
  int limit = 20;
  Timer? _debounce;

  AllAnnouncementsCubit(
      {required this.announcementsRepo,
      required this.scrollController,
      required this.searchController,
      this.companyId})
      : super(const AllAnnouncementsInitial()) {
    _onScroll();
  }

  void searchAnnouncements(String? text) =>
      _debounceFunction(() => getAnnouncements());

  Future<void> _debounceFunction(Future<void> Function() func,
      [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }

  Future<void> getAnnouncements({int offset = 0}) async {
    try {
      final searchText = searchController.text.trim();
      currentSearchValue = searchText.isEmpty ? null : searchText;

      emit(AllAnnouncementsLoading(
          announcements: announcements, hasReachedMax: false));

      String? searchParam = searchText.isEmpty ? null : searchText;
      final response = await announcementsRepo.getPromotions(
          limit: limit, companyId: companyId, search: searchParam);

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

  void _onScroll() {
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

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
