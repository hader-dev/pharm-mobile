import 'dart:async' show Timer;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../../../repositories/remote/company/company_repository_impl.dart';
import '../../../../../../utils/enums.dart';

part 'vendors_state.dart';

class VendorsCubit extends Cubit<VendorsState> {
  int totalVendorsCount = 0;

  int offSet = 0;
  Timer? _debounce;
  List<Company> vendorsList = [];
  SearchVendorFilters? selectedVendorSearchFilter;
  DistributorCategory? selectedDistributorTypeFilter;
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
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        if (offSet < totalVendorsCount) {
          await loadMoreVendors();
        } else {
          emit(VendorsLoadLimitReached());
        }
      }
    });
  }

  Future<void> fetchVendors({
    int offset = 0,
    String searchValue = '',
  }) async {
    try {
      emit(VendorsLoading());
      vendorsList = await companyRepository.getCompanies(
          limit: PaginationConstants.resultsPerPage,
          offset: offSet,
          searchFilter: selectedVendorSearchFilter,
          fields: BaseCompany.baseCompanyFields,
          distributorCategoryId:
              selectedDistributorTypeFilter == DistributorCategory.both ? null : selectedDistributorTypeFilter?.id,
          companyType: CompanyType.distributor,
          search: searchValue);
      totalVendorsCount = vendorsList.length;
      emit(VendorsLoaded());
    } catch (e,stack) {
      debugPrintStack(stackTrace: stack);
      debugPrint("Error fetching vendors: $e");
      vendorsList = [];
      emit(VendorsLoadingFailed());
    }
  }

  Future<void> loadMoreVendors() async {
    try {
      if (offSet >= totalVendorsCount) {
        emit(VendorsLoadLimitReached());
        return;
      }

      offSet = offSet + PaginationConstants.resultsPerPage;
      emit(VendorsLoading());
      List<Company> moreCompanies = await companyRepository.getCompanies(
        limit: PaginationConstants.resultsPerPage,
        offset: offSet,
        searchFilter: selectedVendorSearchFilter,
        distributorCategoryId: selectedDistributorTypeFilter?.id,
        search: searchController.text,
        companyType: CompanyType.distributor,
      );

      vendorsList.addAll(moreCompanies);
      totalVendorsCount = vendorsList.length;
      emit(VendorsLoaded());
    } catch (e) {
      offSet = offSet - PaginationConstants.resultsPerPage;
      emit(VendorsLoadingFailed());
    }
  }

  resetSearchFilters() {
    selectedVendorSearchFilter = null;
    selectedDistributorTypeFilter = null;
    fetchVendors();
    emit(VendorSearchFilterChanged());
  }

  void changeVendorsSearchFilter(SearchVendorFilters filter) {
    selectedVendorSearchFilter = filter;
    emit(VendorSearchFilterChanged());
  }

  void changeDistributorsCategoryFilter(DistributorCategory filter) {
    selectedDistributorTypeFilter = filter;
    emit(VendorSearchFilterChanged());
  }

  void searchVendor(String? text) => _debounceFunction(() => fetchVendors(searchValue: text ?? ''));

  Future<void> _debounceFunction(Future<void> Function() func, [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }
}
