import 'dart:async' show Timer;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/vendors.dart'
    show VendorsPageState;
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart'
    show GlobalExceptionHandler;
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

part 'vendors_state.dart';

class VendorsCubit extends Cubit<VendorsState> {
  Timer? _debounce;
  CompanyRepository companyRepository;

  bool _listenerAttached = false;

  VendorsCubit({
    required this.companyRepository,
    required ScrollController scrollController,
    required TextEditingController searchController,
  }) : super(VendorsInitial(
          scrollController: scrollController,
          searchController: searchController,
          selectedVendorSearchFilter: SearchVendorFilters.name,
        ));

  ScrollController get scrollController {
    if (!_listenerAttached) {
      state.scrollController.addListener(_onScroll);
      _listenerAttached = true;
    }
    return state.scrollController;
  }

  void _onScroll() {
    if (state.scrollController.position.maxScrollExtent >=
        MediaQuery.sizeOf(RoutingManager.rootNavigatorKey.currentContext!)
                .height *
            .6) {
      if (state.scrollController.position.pixels > 5 &&
          state.scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        VendorsPageState.animationController.forward();
      }
      if (state.scrollController.position.pixels > 5 &&
          state.scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        VendorsPageState.animationController.reverse();
      }
    }
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      if (state.offSet < state.totalVendorsCount) {
        loadMoreVendors();
      } else {
        emit(state.toLoadLimitReached());
      }
    }

    final currentOffset = scrollController.offset;
    bool newDisplayFilters = state.displayFilters;

    if (currentOffset > state.lastOffset) {
      newDisplayFilters = false;
    } else if (currentOffset < state.lastOffset) {
      newDisplayFilters = true;
    }

    if (newDisplayFilters != state.displayFilters) {
      emit(state.toScroll(
          offset: currentOffset, displayFilters: newDisplayFilters));
    }
  }

  Future<void> fetchVendors({
    int offSet = 0,
    String searchValue = '',
  }) async {
    try {
      emit(state.toLoading());
      final vendorsList = await companyRepository.getCompanies(
          limit: PaginationConstants.resultsPerPage,
          offset: offSet,
          searchFilter: state.selectedVendorSearchFilter,
          fields: BaseCompany.baseCompanyFields,
          distributorCategoryId:
              state.selectedDistributorTypeFilter == DistributorCategory.Both
                  ? null
                  : state.selectedDistributorTypeFilter?.id,
          companyType: CompanyType.Distributor,
          computeFavorite: true,
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
      emit(state.toLoadingMore(offSet));
      List<Company> moreCompanies = await companyRepository.getCompanies(
        limit: PaginationConstants.resultsPerPage,
        offset: offSet,
        searchFilter: state.selectedVendorSearchFilter,
        distributorCategoryId: state.selectedDistributorTypeFilter?.id,
        search: state.searchController.text,
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
      selectedVendorSearchFilter: SearchVendorFilters.name,
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

  Future<void> likeVendor(String vendorId) async {
    try {
      await companyRepository.likeVendor(companyId: vendorId);

      emit(state.toLiked(vendorId: vendorId, isLiked: true));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.tolikeFailed(vendroId: vendorId));
    }
  }

  Future<void> unlikeVendor(String vendorId) async {
    try {
      await companyRepository.unlikeVendor(companyId: vendorId);
      emit(state.toLiked(vendorId: vendorId, isLiked: false));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.tolikeFailed(vendroId: vendorId));
    }
  }
}
