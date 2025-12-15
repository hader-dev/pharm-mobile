import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/models/para_pharm_filters.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart' show Brand, Category;
import 'package:hader_pharm_mobile/utils/debounce.dart' show DebounceManager;

import '../../../../../repositories/remote/para_pharm_brand/para_pharm_brand_repository_impl.dart'
    show ParaPharmBrandRepository;
import '../../../../../repositories/remote/para_pharm_category/para_pharm_category_repository_impl.dart'
    show ParaPharmCategoryRepository;

part 'para_pharm_filters_state.dart';

class ParaPharmFiltersCubit extends Cubit<ParaPharmFiltersState> {
  ParaPharmFilters appliedFilters = const ParaPharmFilters();
  ParaPharmFilters tempFilters = const ParaPharmFilters();
  ParaPharmBrandRepository paraPharmBrandRepository;
  ParaPharmCategoryRepository paraPharmCategoryRepository;
  List<Brand> brands = [];
  List<Category> categories = [];
  TextEditingController brandSearchController = TextEditingController();
  TextEditingController categorySearchController = TextEditingController();
  final DebounceManager debounceManager = DebounceManager();
  ParaPharmFiltersCubit({
    required this.paraPharmBrandRepository,
    required this.paraPharmCategoryRepository,
  }) : super(ParaPharmFiltersInitial());

  void initFilters(ParaPharmFilters filters) {
    appliedFilters = filters;
    tempFilters = filters;
    brandSearchController.text = filters.brand?.name ?? '';
    categorySearchController.text = filters.category?.name ?? '';
    emit(ParaPharmFiltersChanged());
  }

  void changeFilters(ParaPharmFilters filters) {
    tempFilters = filters;
    emit(ParaPharmFiltersChanged());
  }

  void applyFilters() {
    appliedFilters = tempFilters;
    emit(ParaPharmFiltersChanged());
  }

  void resetFilters() {
    appliedFilters = const ParaPharmFilters();
    tempFilters = const ParaPharmFilters();
    emit(ParaPharmFiltersChanged());
  }

  void searchBrands({String? searchValue}) async {
    try {
      emit(ParaPharmFiltersBrandSearchLoading());
      if (searchValue == null && searchValue!.isEmpty) {
        brands.clear();

        emit(ParaPharmFiltersBrandSearchLoaded());
      }
      debounceManager.debounce(
          tag: 'searchBrands',
          action: () async {
            brands = await paraPharmBrandRepository.getParaPharmBrands(searchValue: searchValue);
            emit(ParaPharmFiltersBrandSearchLoaded());
          });
    } catch (e) {
      emit(ParaPharmFiltersBrandSearchLoadingFailed());
    }
  }

  void searchCategories({String? searchValue}) async {
    emit(ParaPharmFiltersCategorySearchLoading());
    categories = await paraPharmCategoryRepository.getParaPharmCategories(searchValue: searchValue);
    emit(ParaPharmFiltersCategorySearchLoaded());
  }
}
