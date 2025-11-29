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

  MedicineDetailsLoading toLoading() => MedicineDetailsLoading.fromState(
        state: this,
      );

  MedicineDetailsLoadError toLoadError() => MedicineDetailsLoadError.fromState(
        state: this,
      );

  MedicineDetailsLoaded toLoaded(MedicineCatalogModel medicineCatalogData) => MedicineDetailsLoaded.fromState(
        state: this,
        medicineCatalogData: medicineCatalogData,
      );

  MedicineDetailsTapIndexChanged toTapIndexChanged(int index) => MedicineDetailsTapIndexChanged.fromState(
        state: this,
        currentTapIndex: index,
      );

  MedicineQuantityChanged toQuantityChanged() => MedicineQuantityChanged.fromState(
        state: this,
      );

  PassingQuickOrder toPassingQuickOrder() => PassingQuickOrder.fromState(
        state: this,
      );

  QuickOrderPassed toQuickOrderPassed() => QuickOrderPassed.fromState(
        state: this,
      );

  PassQuickOrderFailed toQuickOrderFailed() => PassQuickOrderFailed.fromState(
        state: this,
      );

  MedicineLikeToggled toToggleLiked(MedicineCatalogModel medicineCatalogData) => MedicineLikeToggled.fromState(
        state: this,
        medicineCatalogData: medicineCatalogData,
      );

  UpdateShippingAddress toUpdateShippingAddress(String shippingAddress) =>
      UpdateShippingAddress.fromState(state: this, shippingAddress: shippingAddress);
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
          medicineCatalogData: medicineCatalogData ?? MedicineCatalogModel.empty(),
          packageQuantityController: packageQuantityController ?? TextEditingController(),
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

final class UpdateShippingAddress extends MedicineDetailsState {
  UpdateShippingAddress.fromState({
    required MedicineDetailsState state,
    required super.shippingAddress,
  }) : super(
            medicineCatalogData: state.medicineCatalogData,
            currentTapIndex: state.currentTapIndex,
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
