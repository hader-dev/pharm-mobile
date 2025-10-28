part of 'para_pharma_details_cubit.dart';

sealed class ParaPharmaDetailsState {
  final ParaPharmaCatalogModel paraPharmaCatalogData;
  final int currentTapIndex;
  final TabController tabController;

  final TextEditingController quantityController;
  final TextEditingController packageQuantityController;

  ParaPharmaDetailsState(
      {required this.paraPharmaCatalogData,
      required this.currentTapIndex,
      required this.tabController,
      required this.quantityController,
      required this.packageQuantityController});

  ParaPharmaDetailsLoading toLoading() {
    return ParaPharmaDetailsLoading.fromState(state: this);
  }

  ParaPharmaDetailsLoaded toLoaded({
    required ParaPharmaCatalogModel data,
  }) {
    return ParaPharmaDetailsLoaded.fromState(state: this, data: data);
  }

  ParaPharmaDetailsLoadError toLoadError() {
    return ParaPharmaDetailsLoadError.fromState(state: this);
  }

  ParaPharmaDetailsTapIndexChanged toTapIndexChanged({
    required int index,
  }) {
    return ParaPharmaDetailsTapIndexChanged.fromState(
        state: this, index: index);
  }

  ParaPharmaQuantityChanged toQuantityChanged() {
    return ParaPharmaQuantityChanged.fromState(state: this);
  }

  PassingQuickOrder toPassingQuickOrder() {
    return PassingQuickOrder.fromState(state: this);
  }

  QuickOrderPassed toQuickOrderPassed() {
    return QuickOrderPassed.fromState(state: this);
  }

  PassQuickOrderFailed toPassQuickOrderFailed() {
    return PassQuickOrderFailed.fromState(state: this);
  }
}

final class ParaPharmaDetailsInitial extends ParaPharmaDetailsState {
  ParaPharmaDetailsInitial(
      {ParaPharmaCatalogModel? paraPharmaCatalogData,
      int? currentTapIndex,
      required super.tabController,
      TextEditingController? quantityController,
      TextEditingController? packageQuantityController})
      : super(
          paraPharmaCatalogData:
              paraPharmaCatalogData ?? ParaPharmaCatalogModel.empty(),
          currentTapIndex: currentTapIndex ?? 0,
          quantityController:
              quantityController ?? TextEditingController(text: '1'),
          packageQuantityController:
              packageQuantityController ?? TextEditingController(text: '1'),
        );
}

final class ParaPharmaDetailsLoading extends ParaPharmaDetailsState {
  ParaPharmaDetailsLoading.fromState({required ParaPharmaDetailsState state})
      : super(
          paraPharmaCatalogData: state.paraPharmaCatalogData,
          currentTapIndex: state.currentTapIndex,
          tabController: state.tabController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
        );
}

final class ParaPharmaDetailsLoaded extends ParaPharmaDetailsState {
  ParaPharmaDetailsLoaded.fromState(
      {required ParaPharmaDetailsState state,
      required ParaPharmaCatalogModel data})
      : super(
          paraPharmaCatalogData: data,
          currentTapIndex: state.currentTapIndex,
          tabController: state.tabController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
        );
}

final class ParaPharmaDetailsLoadError extends ParaPharmaDetailsState {
  ParaPharmaDetailsLoadError.fromState({required ParaPharmaDetailsState state})
      : super(
          paraPharmaCatalogData: state.paraPharmaCatalogData,
          currentTapIndex: state.currentTapIndex,
          tabController: state.tabController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
        );
}

final class ParaPharmaDetailsTapIndexChanged extends ParaPharmaDetailsState {
  ParaPharmaDetailsTapIndexChanged.fromState(
      {required ParaPharmaDetailsState state, required int index})
      : super(
          paraPharmaCatalogData: state.paraPharmaCatalogData,
          currentTapIndex: index,
          tabController: state.tabController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
        );
}

final class ParaPharmaQuantityChanged extends ParaPharmaDetailsState {
  ParaPharmaQuantityChanged.fromState({required ParaPharmaDetailsState state})
      : super(
          paraPharmaCatalogData: state.paraPharmaCatalogData,
          currentTapIndex: state.currentTapIndex,
          tabController: state.tabController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
        );
}

final class PassingQuickOrder extends ParaPharmaDetailsState {
  PassingQuickOrder.fromState({required ParaPharmaDetailsState state})
      : super(
          paraPharmaCatalogData: state.paraPharmaCatalogData,
          currentTapIndex: state.currentTapIndex,
          tabController: state.tabController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
        );
}

final class QuickOrderPassed extends ParaPharmaDetailsState {
  QuickOrderPassed.fromState({required ParaPharmaDetailsState state})
      : super(
          paraPharmaCatalogData: state.paraPharmaCatalogData,
          currentTapIndex: state.currentTapIndex,
          tabController: state.tabController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
        );
}

final class PassQuickOrderFailed extends ParaPharmaDetailsState {
  PassQuickOrderFailed.fromState({required ParaPharmaDetailsState state})
      : super(
          paraPharmaCatalogData: state.paraPharmaCatalogData,
          currentTapIndex: state.currentTapIndex,
          tabController: state.tabController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
        );
}
