part of 'wilaya_cubit.dart';

sealed class WilayaState {
  final List<Wilaya> wilayas;
  final List<Town> towns;
  final bool loadedWilaya;
  final Wilaya? selectedWilaya;
  final Town? selectedTown;
  final String locale;

  WilayaState(
      {required this.wilayas,
      required this.towns,
      required this.loadedWilaya,
      this.selectedWilaya,
      this.selectedTown,
      required this.locale});

  WilayaIsLoading toLoadingWilaya() => WilayaIsLoading.fromState(state: this);
  WilayaLoaded toLoadedWilaya({
    required List<Wilaya> wilayas,
  }) =>
      WilayaLoaded.fromState(state: this, wilayas: wilayas, towns: towns);

  WilayaLoadingError toLoadingWilayaError() =>
      WilayaLoadingError.fromState(state: this);

  TownlsLoading toLoadingTowns() => TownlsLoading.fromState(state: this);
  TownLoaded toLoadedTowns({
    required List<Town> towns,
  }) =>
      TownLoaded.fromState(state: this, towns: towns);

  TownLoadingError toLoadingTownsError() =>
      TownLoadingError.fromState(state: this);

  SelectionUpdated toSelectWilaya({
    required Wilaya? wilaya,
  }) =>
      SelectionUpdated.fromState(
          state: this, selectedWilaya: wilaya, selectedTown: null);

  SelectionUpdated toSelectTown({
    required Town? town,
  }) =>
      SelectionUpdated.fromState(
          state: this, selectedWilaya: selectedWilaya, selectedTown: town);

  WilayaStateInitial toInitial({required String locale}) =>
      WilayaStateInitial.fromState(
        locale: locale,
        state: this,
      );
}

final class WilayaStateInitial extends WilayaState {
  WilayaStateInitial({
    super.locale = 'en',
    super.selectedWilaya,
    super.selectedTown,
    super.wilayas = const [],
    super.towns = const [],
    super.loadedWilaya = false,
  });

  WilayaStateInitial.fromState({
    required WilayaState state,
    required super.locale,
  }) : super(
          wilayas: state.wilayas,
          towns: state.towns,
          loadedWilaya: false,
          selectedWilaya: state.selectedWilaya,
          selectedTown: state.selectedTown,
        );
}

final class SelectionUpdated extends WilayaState {
  SelectionUpdated.fromState(
      {required WilayaState state, super.selectedWilaya, super.selectedTown})
      : super(
            wilayas: state.wilayas,
            towns: state.towns,
            loadedWilaya: state.loadedWilaya,
            locale: state.locale);
}

final class WilayaIsLoading extends WilayaState {
  WilayaIsLoading.fromState({
    required WilayaState state,
  }) : super(
            wilayas: state.wilayas,
            towns: state.towns,
            loadedWilaya: state.loadedWilaya,
            selectedWilaya: state.selectedWilaya,
            selectedTown: state.selectedTown,
            locale: state.locale);
}

final class WilayaLoaded extends WilayaState {
  WilayaLoaded.fromState({
    required WilayaState state,
    required super.wilayas,
    required super.towns,
  }) : super(
            loadedWilaya: true,
            selectedWilaya: state.selectedWilaya,
            selectedTown: state.selectedTown,
            locale: state.locale);
}

final class WilayaLoadingError extends WilayaState {
  WilayaLoadingError.fromState({
    required WilayaState state,
  }) : super(
            wilayas: [],
            towns: state.towns,
            loadedWilaya: state.loadedWilaya,
            selectedWilaya: state.selectedWilaya,
            selectedTown: state.selectedTown,
            locale: state.locale);
}

final class TownlsLoading extends WilayaState {
  TownlsLoading.fromState({
    required WilayaState state,
  }) : super(
            wilayas: state.wilayas,
            towns: state.towns,
            loadedWilaya: state.loadedWilaya,
            selectedWilaya: state.selectedWilaya,
            selectedTown: state.selectedTown,
            locale: state.locale);
}

final class TownLoaded extends WilayaState {
  TownLoaded.fromState({
    required WilayaState state,
    required super.towns,
  }) : super(
            wilayas: state.wilayas,
            loadedWilaya: state.loadedWilaya,
            selectedWilaya: state.selectedWilaya,
            selectedTown: state.selectedTown,
            locale: state.locale);
}

final class TownLoadingError extends WilayaState {
  TownLoadingError.fromState({
    required WilayaState state,
  }) : super(
            wilayas: state.wilayas,
            towns: [],
            loadedWilaya: state.loadedWilaya,
            selectedWilaya: state.selectedWilaya,
            selectedTown: state.selectedTown,
            locale: state.locale);
}
