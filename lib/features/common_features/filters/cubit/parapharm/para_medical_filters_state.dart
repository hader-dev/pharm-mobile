part of 'para_medical_filters_cubit.dart';

sealed class ParaMedicalFiltersState {
  final int pageIndex;
  final ParaMedicalFilters filtersSource;
  final ParaMedicalFilters appliedFilters;
  final ParaMedicalFiltersKeys currentKey;
  final Timer? searchDebounceTimer;

  const ParaMedicalFiltersState({
    this.pageIndex = 0,
    this.filtersSource = const ParaMedicalFilters(),
    this.appliedFilters = const ParaMedicalFilters(),
    this.currentKey = ParaMedicalFiltersKeys.name,
    this.searchDebounceTimer,
  });

  ParaMedicalFiltersState copyWith({
    int? pageIndex,
    ParaMedicalFilters? filtersSource,
    ParaMedicalFilters? appliedFilters,
    ParaMedicalFiltersKeys? currentKey,
    Timer? searchDebounceTimer,
  }) {
    return ParaMedicalFiltersStateInitial(
      pageIndex: pageIndex ?? this.pageIndex,
      filtersSource: filtersSource ?? this.filtersSource,
      appliedFilters: appliedFilters ?? this.appliedFilters,
      currentKey: currentKey ?? this.currentKey,
      searchDebounceTimer: searchDebounceTimer ?? this.searchDebounceTimer,
    );
  }

  ParaMedicalFiltersStateInitial initial({
    int pageIndex = 0,
    ParaMedicalFilters filtersSource = const ParaMedicalFilters(),
    ParaMedicalFilters appliedFilters = const ParaMedicalFilters(),
    ParaMedicalFiltersKeys currentKey = ParaMedicalFiltersKeys.name,
    Timer? searchDebounceTimer,
  }) {
    return ParaMedicalFiltersStateInitial(
      pageIndex: pageIndex,
      filtersSource: filtersSource,
      appliedFilters: appliedFilters,
      currentKey: currentKey,
      searchDebounceTimer: searchDebounceTimer,
    );
  }

  ParaMedicalFiltersIsLoading loading() => ParaMedicalFiltersIsLoading(
        pageIndex: pageIndex,
        filtersSource: filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  ParaMedicalFiltersLoaded loaded({
    ParaMedicalFilters? updatedFiltersSource,
  }) =>
      ParaMedicalFiltersLoaded(
        pageIndex: pageIndex,
        filtersSource: updatedFiltersSource ?? filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  ParaMedicalFiltersLoadingError loadingError() =>
      ParaMedicalFiltersLoadingError(
        pageIndex: pageIndex,
        filtersSource: filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  ParaMedicalFiltersPageChanged pageChanged({int? newPageIndex}) =>
      ParaMedicalFiltersPageChanged(
        pageIndex: newPageIndex ?? pageIndex,
        filtersSource: filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  ParaMedicalFiltersUpdated updated({
    ParaMedicalFilters? updatedAppliedFilters,
    ParaMedicalFilters? updatedFiltersSource,
    ParaMedicalFiltersKeys? updatedCurrentKey,
  }) =>
      ParaMedicalFiltersUpdated(
        pageIndex: pageIndex,
        filtersSource: updatedFiltersSource ?? filtersSource,
        appliedFilters: updatedAppliedFilters ?? appliedFilters,
        currentKey: updatedCurrentKey ?? currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );
}

final class ParaMedicalFiltersStateInitial extends ParaMedicalFiltersState {
  const ParaMedicalFiltersStateInitial({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class ParaMedicalFiltersIsLoading extends ParaMedicalFiltersState {
  const ParaMedicalFiltersIsLoading({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class ParaMedicalFiltersLoaded extends ParaMedicalFiltersState {
  const ParaMedicalFiltersLoaded({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class ParaMedicalFiltersLoadingError extends ParaMedicalFiltersState {
  const ParaMedicalFiltersLoadingError({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class ParaMedicalFiltersPageChanged extends ParaMedicalFiltersState {
  const ParaMedicalFiltersPageChanged({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class ParaMedicalFiltersUpdated extends ParaMedicalFiltersState {
  const ParaMedicalFiltersUpdated({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}
