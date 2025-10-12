part of 'vendors_cubit.dart';

class VendorsState {
  final int totalVendorsCount;
  final List<Company> vendorsList;

  final SearchVendorFilters? selectedVendorSearchFilter;
  final DistributorCategory? selectedDistributorTypeFilter;
  final int offSet;

  VendorsState({
    required this.totalVendorsCount,
    required this.vendorsList,
    this.selectedVendorSearchFilter,
    this.selectedDistributorTypeFilter,
    required this.offSet,
  });

  VendorsState copyWith({
    int? totalVendorsCount,
    List<Company>? vendorsList,
    SearchVendorFilters? selectedVendorSearchFilter,
    DistributorCategory? selectedDistributorTypeFilter,
    int? offSet,
  }) =>
      VendorsState(
        totalVendorsCount: totalVendorsCount ?? this.totalVendorsCount,
        vendorsList: vendorsList ?? this.vendorsList,
        selectedVendorSearchFilter:
            selectedVendorSearchFilter ?? this.selectedVendorSearchFilter,
        selectedDistributorTypeFilter:
            selectedDistributorTypeFilter ?? this.selectedDistributorTypeFilter,
        offSet: offSet ?? this.offSet,
      );

  VendorsInitial toInitial() => VendorsInitial(
        totalVendorsCount: totalVendorsCount,
        vendorsList: vendorsList,
        selectedVendorSearchFilter: selectedVendorSearchFilter,
        selectedDistributorTypeFilter: selectedDistributorTypeFilter,
        offSet: offSet,
      );

  VendorsLoading toLoading() => VendorsLoading.fromState(state: this);
  VendorsLoadingMore toLoadingMore() =>
      VendorsLoadingMore.fromState(state: this);
  VendorsLoaded toLoaded({required List<Company> vendors}) =>
      VendorsLoaded.fromState(state: this, vendorsList: vendors);
  VendorsLoadingFailed toLoadingFailed() =>
      VendorsLoadingFailed.fromState(state: this);

  VendorsLoadLimitReached toLoadLimitReached() =>
      VendorsLoadLimitReached.fromState(state: this);

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
}

final class VendorsInitial extends VendorsState {
  VendorsInitial(
      {super.totalVendorsCount = 0,
      super.vendorsList = const [],
      super.selectedVendorSearchFilter,
      super.selectedDistributorTypeFilter,
      super.offSet = 0});
}

final class VendorsLoading extends VendorsInitial {
  VendorsLoading.fromState({required VendorsState state})
      : super(
          totalVendorsCount: state.totalVendorsCount,
          vendorsList: state.vendorsList,
          selectedVendorSearchFilter: state.selectedVendorSearchFilter,
          selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
          offSet: state.offSet,
        );
}

final class VendorsLoadingMore extends VendorsInitial {
  VendorsLoadingMore.fromState({required VendorsState state})
      : super(
          totalVendorsCount: state.totalVendorsCount,
          vendorsList: state.vendorsList,
          selectedVendorSearchFilter: state.selectedVendorSearchFilter,
          selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
          offSet: state.offSet,
        );
}

final class VendorsLoaded extends VendorsInitial {
  VendorsLoaded({
    super.totalVendorsCount,
    super.vendorsList,
    super.selectedVendorSearchFilter,
    super.selectedDistributorTypeFilter,
    super.offSet,
  });

  VendorsLoaded.fromState(
      {required VendorsState state, required super.vendorsList})
      : super(
          totalVendorsCount: vendorsList.length,
          selectedVendorSearchFilter: state.selectedVendorSearchFilter,
          selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
          offSet: state.offSet,
        );
}

final class VendorsLoadingFailed extends VendorsInitial {
  VendorsLoadingFailed.fromState({required VendorsState state})
      : super(
          totalVendorsCount: state.totalVendorsCount,
          vendorsList: state.vendorsList,
          selectedVendorSearchFilter: state.selectedVendorSearchFilter,
          selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
          offSet: state.offSet,
        );
}

final class VendorsLoadLimitReached extends VendorsInitial {
  VendorsLoadLimitReached.fromState({required VendorsState state})
      : super(
          totalVendorsCount: state.totalVendorsCount,
          vendorsList: state.vendorsList,
          selectedVendorSearchFilter: state.selectedVendorSearchFilter,
          selectedDistributorTypeFilter: state.selectedDistributorTypeFilter,
          offSet: state.offSet,
        );
}

final class VendorSearchFilterChanged extends VendorsInitial {
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
              ? null
              : selectedVendorSearchFilter ?? state.selectedVendorSearchFilter,
          selectedDistributorTypeFilter: resetDistributorTypeFilter
              ? null
              : selectedDistributorTypeFilter ??
                  state.selectedDistributorTypeFilter,
          offSet: state.offSet,
        );
}
