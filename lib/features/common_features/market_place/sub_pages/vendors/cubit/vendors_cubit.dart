import 'dart:async' show Timer;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

part 'vendors_state.dart';

class VendorsCubit extends Cubit<VendorsState> {
  Timer? _debounce;
  CompanyRepository companyRepository;
  final ScrollController scrollController;
  final TextEditingController searchController;
  VendorsCubit({
    required this.companyRepository,
    required this.scrollController,
    required this.searchController,
  }) : super(VendorsInitial()) {
    _onScroll();
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalVendorsCount) {
          await loadMoreVendors();
        } else {
          emit(state.toLoadLimitReached());
        }
      }
    });
  }

  Future<void> fetchVendors({
    int offset = 0,
    String searchValue = '',
  }) async {
    try {
      emit(state.toLoading());
      final vendorsList = await companyRepository.getCompanies(
          limit: PaginationConstants.resultsPerPage,
          offset: state.offSet,
          searchFilter: state.selectedVendorSearchFilter,
          fields: BaseCompany.baseCompanyFields,
          distributorCategoryId:
              state.selectedDistributorTypeFilter == DistributorCategory.Both
                  ? null
                  : state.selectedDistributorTypeFilter?.id,
          companyType: CompanyType.Distributor,
          search: searchValue);
      emit(state.toLoaded(vendors: vendorsList));
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      debugPrint("Error fetching vendors: $e");
      emit(state.toLoadingFailed());
    }
  }

  Future<void> loadMoreVendors() async {
    try {
      final offSet = state.offSet + PaginationConstants.resultsPerPage;
      emit(state.toLoadingMore());
      List<Company> moreCompanies = await companyRepository.getCompanies(
        limit: PaginationConstants.resultsPerPage,
        offset: offSet,
        searchFilter: state.selectedVendorSearchFilter,
        distributorCategoryId: state.selectedDistributorTypeFilter?.id,
        search: searchController.text,
        companyType: CompanyType.Distributor,
      );

      final vendorsList = state.vendorsList.toList();
      vendorsList.addAll(moreCompanies);

      if (moreCompanies.isEmpty) {
        emit(state.toLoadLimitReached());
        return;
      }
      emit(state.toLoaded(
        vendors: vendorsList,
      ));
    } catch (e) {
      emit(state.toLoadingFailed());
    }
  }

  void resetSearchFilters() {
    fetchVendors();
    emit(state.toFiltersChanged(
      resetSearchFilter: true,
      resetDistributorTypeFilter: true,
    ));
  }

  void changeVendorsSearchFilter(SearchVendorFilters filter) {
    emit(state.toFiltersChanged(
      selectedVendorSearchFilter: filter,
    ));
  }

  void changeDistributorsCategoryFilter(DistributorCategory filter) {
    emit(state.toFiltersChanged(
      selectedDistributorTypeFilter: filter,
    ));
  }

  void searchVendor(String? text) =>
      _debounceFunction(() => fetchVendors(searchValue: text ?? ''));

  Future<void> _debounceFunction(Future<void> Function() func,
      [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }
}
