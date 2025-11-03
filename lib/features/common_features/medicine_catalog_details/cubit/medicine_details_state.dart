part of 'medicine_details_cubit.dart';

sealed class MedicineDetailsState {
  final MedicineCatalogModel medicineCatalogData;
  final int currentTapIndex;
  final String shippingAddress;

  final TabController tabController;
  final TextEditingController packageQuantityController;
  final TextEditingController quantityController;

  const MedicineDetailsState({
    required this.medicineCatalogData,
    required this.currentTapIndex,
    required this.shippingAddress,
    required this.tabController,
    required this.packageQuantityController,
    required this.quantityController,
  });

  // Factory constructors for transitions
  MedicineDetailsInitial initial({
    MedicineCatalogModel? medicineCatalogData,
    int? currentTapIndex,
    String? shippingAddress,
  }) =>
      MedicineDetailsInitial(
        medicineCatalogData: medicineCatalogData ?? this.medicineCatalogData,
        currentTapIndex: currentTapIndex ?? this.currentTapIndex,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        tabController: tabController,
      );

  MedicineDetailsLoading loading() => MedicineDetailsLoading.fromState(
        state: this,
      );

  MedicineDetailsLoadError loadError() => MedicineDetailsLoadError.fromState(
        state: this,
      );

  MedicineDetailsLoaded loaded(MedicineCatalogModel medicineCatalogData) =>
      MedicineDetailsLoaded.fromState(
        state: this,
        medicineCatalogData: medicineCatalogData,
      );

  MedicineDetailsTapIndexChanged tapIndexChanged(int index) =>
      MedicineDetailsTapIndexChanged.fromState(
        state: this,
        currentTapIndex: index,
      );

  MedicineQuantityChanged quantityChanged() =>
      MedicineQuantityChanged.fromState(
        state: this,
      );

  PassingQuickOrder passingQuickOrder() => PassingQuickOrder.fromState(
        state: this,
      );

  QuickOrderPassed quickOrderPassed() => QuickOrderPassed.fromState(
        state: this,
      );

  PassQuickOrderFailed quickOrderFailed() => PassQuickOrderFailed.fromState(
        state: this,
      );

  MedicineLikeToggled toToggleLiked(MedicineCatalogModel medicineCatalogData) =>
      MedicineLikeToggled.fromState(
        state: this,
        medicineCatalogData: medicineCatalogData,
      );
}

// ------------------ States ------------------

final class MedicineDetailsInitial extends MedicineDetailsState {
  MedicineDetailsInitial({
    MedicineCatalogModel? medicineCatalogData,
    super.currentTapIndex = 0,
    super.shippingAddress = "",
    required super.tabController,
    TextEditingController? packageQuantityController,
    TextEditingController? quantityController,
  }) : super(
          medicineCatalogData:
              medicineCatalogData ?? MedicineCatalogModel.empty(),
          packageQuantityController:
              packageQuantityController ?? TextEditingController(),
          quantityController: quantityController ?? TextEditingController(),
        );
}

final class MedicineDetailsLoading extends MedicineDetailsState {
  MedicineDetailsLoading.fromState({
    required MedicineDetailsState state,
  }) : super(
            medicineCatalogData: state.medicineCatalogData,
            currentTapIndex: state.currentTapIndex,
            shippingAddress: state.shippingAddress,
            tabController: state.tabController,
            packageQuantityController: state.packageQuantityController,
            quantityController: state.quantityController);
}

final class MedicineDetailsLoaded extends MedicineDetailsState {
  MedicineDetailsLoaded.fromState({
    required MedicineDetailsState state,
    required super.medicineCatalogData,
  }) : super(
            currentTapIndex: state.currentTapIndex,
            shippingAddress: state.shippingAddress,
            tabController: state.tabController,
            packageQuantityController: state.packageQuantityController,
            quantityController: state.quantityController);
}

final class MedicineDetailsLoadError extends MedicineDetailsState {
  MedicineDetailsLoadError.fromState({
    required MedicineDetailsState state,
  }) : super(
            medicineCatalogData: state.medicineCatalogData,
            currentTapIndex: state.currentTapIndex,
            shippingAddress: state.shippingAddress,
            tabController: state.tabController,
            packageQuantityController: state.packageQuantityController,
            quantityController: state.quantityController);
}

final class MedicineDetailsTapIndexChanged extends MedicineDetailsState {
  MedicineDetailsTapIndexChanged.fromState({
    required MedicineDetailsState state,
    required super.currentTapIndex,
  }) : super(
            medicineCatalogData: state.medicineCatalogData,
            shippingAddress: state.shippingAddress,
            tabController: state.tabController,
            packageQuantityController: state.packageQuantityController,
            quantityController: state.quantityController);
}

final class MedicineQuantityChanged extends MedicineDetailsState {
  MedicineQuantityChanged.fromState({
    required MedicineDetailsState state,
  }) : super(
            currentTapIndex: state.currentTapIndex,
            shippingAddress: state.shippingAddress,
            tabController: state.tabController,
            medicineCatalogData: state.medicineCatalogData,
            packageQuantityController: state.packageQuantityController,
            quantityController: state.quantityController);
}

final class PassingQuickOrder extends MedicineDetailsState {
  PassingQuickOrder.fromState({
    required MedicineDetailsState state,
  }) : super(
            medicineCatalogData: state.medicineCatalogData,
            currentTapIndex: state.currentTapIndex,
            shippingAddress: state.shippingAddress,
            tabController: state.tabController,
            packageQuantityController: state.packageQuantityController,
            quantityController: state.quantityController);
}

final class QuickOrderPassed extends MedicineDetailsState {
  QuickOrderPassed.fromState({
    required MedicineDetailsState state,
  }) : super(
            medicineCatalogData: state.medicineCatalogData,
            currentTapIndex: state.currentTapIndex,
            shippingAddress: state.shippingAddress,
            tabController: state.tabController,
            packageQuantityController: state.packageQuantityController,
            quantityController: state.quantityController);
}

final class PassQuickOrderFailed extends MedicineDetailsState {
  PassQuickOrderFailed.fromState({
    required MedicineDetailsState state,
  }) : super(
            medicineCatalogData: state.medicineCatalogData,
            currentTapIndex: state.currentTapIndex,
            shippingAddress: state.shippingAddress,
            tabController: state.tabController,
            packageQuantityController: state.packageQuantityController,
            quantityController: state.quantityController);
}

final class MedicineLikeToggled extends MedicineDetailsState {
  MedicineLikeToggled.fromState({
    required MedicineDetailsState state,
    required super.medicineCatalogData,
  }) : super(
            currentTapIndex: state.currentTapIndex,
            shippingAddress: state.shippingAddress,
            tabController: state.tabController,
            packageQuantityController: state.packageQuantityController,
            quantityController: state.quantityController);
}
