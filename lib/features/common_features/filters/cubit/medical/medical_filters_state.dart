part of 'medical_filters_cubit.dart';

sealed class MedicalFiltersState {
  final int pageIndex;
  final MedicalFilters filtersSource;
  final MedicalFilters appliedFilters;
  final MedicalFiltersKeys currentKey;
  final Timer? searchDebounceTimer;

  const MedicalFiltersState({
    this.pageIndex = 0,
    this.filtersSource = const MedicalFilters(),
    this.appliedFilters = const MedicalFilters(),
    this.currentKey = MedicalFiltersKeys.dci,
    this.searchDebounceTimer,
  });

  MedicalFiltersState copyWith({
    int? pageIndex,
    MedicalFilters? filtersSource,
    MedicalFilters? appliedFilters,
    MedicalFiltersKeys? currentKey,
    Timer? searchDebounceTimer,
  }) {
    return MedicalFiltersStateInitial(
      pageIndex: pageIndex ?? this.pageIndex,
      filtersSource: filtersSource ?? this.filtersSource,
      appliedFilters: appliedFilters ?? this.appliedFilters,
      currentKey: currentKey ?? this.currentKey,
      searchDebounceTimer: searchDebounceTimer ?? this.searchDebounceTimer,
    );
  }

  MedicalFiltersStateInitial initial({
    int pageIndex = 0,
    MedicalFilters filtersSource = const MedicalFilters(),
    MedicalFilters appliedFilters = const MedicalFilters(),
    MedicalFiltersKeys currentKey = MedicalFiltersKeys.dci,
    Timer? searchDebounceTimer,
  }) {
    return MedicalFiltersStateInitial(
      pageIndex: pageIndex,
      filtersSource: filtersSource,
      appliedFilters: appliedFilters,
      currentKey: currentKey,
      searchDebounceTimer: searchDebounceTimer,
    );
  }

  MedicalFiltersIsLoading loading() => MedicalFiltersIsLoading(
        pageIndex: pageIndex,
        filtersSource: filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  MedicalFiltersLoaded loaded({
    MedicalFilters? updatedFiltersSource,
  }) =>
      MedicalFiltersLoaded(
        pageIndex: pageIndex,
        filtersSource: updatedFiltersSource ?? filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  MedicalFiltersLoadingError loadingError() => MedicalFiltersLoadingError(
        pageIndex: pageIndex,
        filtersSource: filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  MedicalFiltersPageChanged pageChanged({int? newPageIndex}) =>
      MedicalFiltersPageChanged(
        pageIndex: newPageIndex ?? pageIndex,
        filtersSource: filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  MedicalFiltersUpdated updated({
    MedicalFilters? updatedAppliedFilters,
    MedicalFilters? updatedFiltersSource,
    MedicalFiltersKeys? updatedCurrentKey,
  }) =>
      MedicalFiltersUpdated(
        pageIndex: pageIndex,
        filtersSource: updatedFiltersSource ?? filtersSource,
        appliedFilters: updatedAppliedFilters ?? appliedFilters,
        currentKey: updatedCurrentKey ?? currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );
}

final class MedicalFiltersStateInitial extends MedicalFiltersState {
  const MedicalFiltersStateInitial({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class MedicalFiltersIsLoading extends MedicalFiltersState {
  const MedicalFiltersIsLoading({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class MedicalFiltersLoaded extends MedicalFiltersState {
  const MedicalFiltersLoaded({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class MedicalFiltersLoadingError extends MedicalFiltersState {
  const MedicalFiltersLoadingError({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class MedicalFiltersPageChanged extends MedicalFiltersState {
  const MedicalFiltersPageChanged({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class MedicalFiltersUpdated extends MedicalFiltersState {
  const MedicalFiltersUpdated({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}
