part of 'vendors_cubit.dart';

class VendorsState {
  final int totalVendorsCount;
  final List<Company> vendorsList;

  final SearchVendorFilters? selectedVendorSearchFilter;
  final DistributorCategory? selectedDistributorTypeFilter;
  final int offSet;

  final ScrollController scrollController;
  final TextEditingController searchController;
  final bool displayFilters;
  final double lastOffset;

  VendorsState({
    required this.totalVendorsCount,
    required this.scrollController,
    required this.searchController,
    required this.vendorsList,
    required this.displayFilters,
    required this.lastOffset,
    this.selectedVendorSearchFilter,
    this.selectedDistributorTypeFilter,
    required this.offSet,
  });

  VendorsLoading toLoading() => VendorsLoading.fromState(state: this);
  VendorsLoadingMore toLoadingMore(int offSet) => VendorsLoadingMore.fromState(offSet: offSet, state: this);
  VendorsLoaded toLoaded({required List<Company> vendors}) =>
      VendorsLoaded.fromState(state: this, vendorsList: vendors);
  VendorsLoadingFailed toLoadingFailed() => VendorsLoadingFailed.fromState(state: this);

  VendorsLoadLimitReached toLoadLimitReached() => VendorsLoadLimitReached.fromState(state: this);

  VendorsScrollChanged toScroll({required double offset, required bool displayFilters}) =>
      VendorsScrollChanged.fromState(state: this, lastOffset: offset, displayFilters: displayFilters);

  VendorSearchFilterChanged toFiltersChanged(
          {SearchVendorFilters? selectedVendorSearchFilter,
          DistributorCategory? selectedDistributorTypeFilter,
          bool resetSearchFilter = false,
          bool resetDistributorTypeFilter = false}) =>
      VendorSearchFilterChanged.fromState(
          state: this,
          selectedVendorSearchFilter: selectedVendorSearchFilter,
          selectedDistributorTypeFilter: selectedDistributorTypeFilter,
          resetSearchFilter: resetSearchFilter,
          resetDistributorTypeFilter: resetDistributorTypeFilter);
  VendorLikeFailed tolikeFailed({required String vendroId}) =>
      VendorLikeFailed.fromState(state: this, vendorId: vendroId);

  VendorLiked toLiked({required String vendorId, required bool isLiked}) {
    final updated = vendorsList.map((element) {
      if (element.id == vendorId) {
        return element.copyWith(isLiked: isLiked);
      }
      return element;
    }).toList();

    return VendorLiked.fromState(
      state: this,
      vendorsList: updated,
      vendorId: vendorId,
      likedOrUnliked: isLiked,
    );
  }
}

final class VendorsInitial extends VendorsState {
  VendorsInitial(
      {super.totalVendorsCount = 0,
      super.vendorsList = const [],
      super.selectedVendorSearchFilter,
      super.selectedDistributorTypeFilter,
      ScrollController? scrollController,
      TextEditingController? searchController,
      super.displayFilters = true,
      super.lastOffset = 0,
      super.offSet = 0})
      : super(
            scrollController: scrollController ?? ScrollController(),
            searchController: searchController ?? TextEditingController());

  VendorsInitial.fromState({
    required VendorsState state,
    int? totalVendorsCount,
    List<Company>? vendorsList,
    SearchVendorFilters? selectedVendorSearchFilter,
    DistributorCategory? selectedDistributorTypeFilter,
    ScrollController? scrollController,
    TextEditingController? searchController,
    int? offSet,
  }) : super(
            displayFilters: state.displayFilters,
            lastOffset: state.lastOffset,
            totalVendorsCount: totalVendorsCount ?? state.totalVendorsCount,
            vendorsList: vendorsList ?? state.vendorsList,
            selectedVendorSearchFilter: selectedVendorSearchFilter ?? state.selectedVendorSearchFilter,
            selectedDistributorTypeFilter: selectedDistributorTypeFilter ?? state.selectedDistributorTypeFilter,
            offSet: offSet ?? state.offSet,
            scrollController: scrollController ?? state.scrollController,
            searchController: searchController ?? state.searchController);
}

final class VendorsLoading extends VendorsState {
  VendorsLoading.fromState({required VendorsState state})
      : super(
            totalVendorsCount: state.totalVendorsCount,
            vendorsList: state.vendorsList,
            selectedVendorSearchFilter: state.selectedVendorSearchFilter,
            selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
            offSet: state.offSet,
            scrollController: state.scrollController,
            searchController: state.searchController,
            displayFilters: state.displayFilters,
            lastOffset: state.lastOffset);
}

final class VendorsLoadingMore extends VendorsState {
  VendorsLoadingMore.fromState({required super.offSet, required VendorsState state})
      : super(
            totalVendorsCount: state.totalVendorsCount,
            vendorsList: state.vendorsList,
            selectedVendorSearchFilter: state.selectedVendorSearchFilter,
            selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
            scrollController: state.scrollController,
            searchController: state.searchController,
            displayFilters: state.displayFilters,
            lastOffset: state.lastOffset);
}

final class VendorsLoaded extends VendorsState {
  VendorsLoaded.fromState({required VendorsState state, required super.vendorsList})
      : super(
            totalVendorsCount: vendorsList.length,
            selectedVendorSearchFilter: state.selectedVendorSearchFilter,
            selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
            offSet: state.offSet,
            scrollController: state.scrollController,
            searchController: state.searchController,
            displayFilters: state.displayFilters,
            lastOffset: state.lastOffset);
}

final class VendorsLoadingFailed extends VendorsState {
  VendorsLoadingFailed.fromState({required VendorsState state})
      : super(
            totalVendorsCount: state.totalVendorsCount,
            vendorsList: state.vendorsList,
            selectedVendorSearchFilter: state.selectedVendorSearchFilter,
            selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
            offSet: state.offSet,
            scrollController: state.scrollController,
            searchController: state.searchController,
            displayFilters: state.displayFilters,
            lastOffset: state.lastOffset);
}

final class VendorsScrollChanged extends VendorsState {
  VendorsScrollChanged.fromState(
      {required VendorsState state, required super.lastOffset, required super.displayFilters})
      : super(
            totalVendorsCount: state.totalVendorsCount,
            vendorsList: state.vendorsList,
            selectedVendorSearchFilter: state.selectedVendorSearchFilter,
            selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
            offSet: state.offSet,
            scrollController: state.scrollController,
            searchController: state.searchController);
}

final class VendorsLoadLimitReached extends VendorsState {
  VendorsLoadLimitReached.fromState({required VendorsState state})
      : super(
            totalVendorsCount: state.totalVendorsCount,
            vendorsList: state.vendorsList,
            selectedVendorSearchFilter: state.selectedVendorSearchFilter,
            selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
            offSet: state.offSet,
            scrollController: state.scrollController,
            searchController: state.searchController,
            displayFilters: state.displayFilters,
            lastOffset: state.lastOffset);
}

final class VendorSearchFilterChanged extends VendorsState {
  VendorSearchFilterChanged.fromState(
      {required VendorsState state,
      SearchVendorFilters? selectedVendorSearchFilter,
      DistributorCategory? selectedDistributorTypeFilter,
      bool resetSearchFilter = false,
      bool resetDistributorTypeFilter = false})
      : super(
            totalVendorsCount: state.totalVendorsCount,
            vendorsList: state.vendorsList,
            selectedVendorSearchFilter: resetSearchFilter
                ? SearchVendorFilters.name
                : selectedVendorSearchFilter ?? state.selectedVendorSearchFilter,
            selectedDistributorTypeFilter: resetDistributorTypeFilter
                ? DistributorCategory.Both
                : selectedDistributorTypeFilter ?? state.selectedDistributorTypeFilter,
            offSet: state.offSet,
            scrollController: state.scrollController,
            searchController: state.searchController,
            displayFilters: state.displayFilters,
            lastOffset: state.lastOffset);
}

final class VendorLiked extends VendorsState {
  final String vendorId;
  final bool likedOrUnliked;

  VendorLiked.fromState({
    required VendorsState state,
    required super.vendorsList,
    required this.vendorId,
    required this.likedOrUnliked,
  }) : super(
          lastOffset: state.lastOffset,
          totalVendorsCount: state.totalVendorsCount,
          offSet: state.offSet,
          displayFilters: state.displayFilters,
          selectedVendorSearchFilter: state.selectedVendorSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class VendorLikeFailed extends VendorsState {
  final String vendorId;

  VendorLikeFailed.fromState({
    required VendorsState state,
    required this.vendorId,
  }) : super(
          vendorsList: state.vendorsList,
          lastOffset: state.lastOffset,
          totalVendorsCount: state.totalVendorsCount,
          offSet: state.offSet,
          displayFilters: state.displayFilters,
          selectedVendorSearchFilter: state.selectedVendorSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}
