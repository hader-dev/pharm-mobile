part of 'medicine_details_cubit.dart';

sealed class MedicineDetailsState {
  final MedicineCatalogModel? medicineCatalogData;
  final int currentTapIndex;
  final String shippingAddress;

  const MedicineDetailsState({
    this.medicineCatalogData,
    this.currentTapIndex = 0,
    this.shippingAddress = "",
  });

  /// Universal copy method
  MedicineDetailsState copyWith({
    MedicineCatalogModel? medicineCatalogData,
    int? currentTapIndex,
    String? shippingAddress,
  }) {
    return MedicineDetailsInitial(
      medicineCatalogData: medicineCatalogData ?? this.medicineCatalogData,
      currentTapIndex: currentTapIndex ?? this.currentTapIndex,
      shippingAddress: shippingAddress ?? this.shippingAddress,
    );
  }

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
      );

  MedicineDetailsLoading loading() => MedicineDetailsLoading(
        medicineCatalogData: medicineCatalogData,
        currentTapIndex: currentTapIndex,
        shippingAddress: shippingAddress,
      );

  MedicineDetailsLoadError loadError() => MedicineDetailsLoadError(
        medicineCatalogData: medicineCatalogData,
        currentTapIndex: currentTapIndex,
        shippingAddress: shippingAddress,
      );

  MedicineDetailsLoaded loaded(MedicineCatalogModel medicineCatalogData) =>
      MedicineDetailsLoaded(
        medicineCatalogData: medicineCatalogData,
        currentTapIndex: currentTapIndex,
        shippingAddress: shippingAddress,
      );

  MedicineDetailsTapIndexChanged tapIndexChanged(int index) =>
      MedicineDetailsTapIndexChanged(
        currentTapIndex: index,
        medicineCatalogData: medicineCatalogData,
        shippingAddress: shippingAddress,
      );

  MedicineQuantityChanged quantityChanged() => MedicineQuantityChanged(
        medicineCatalogData: medicineCatalogData,
        currentTapIndex: currentTapIndex,
        shippingAddress: shippingAddress,
      );

  PassingQuickOrder passingQuickOrder() => PassingQuickOrder(
        medicineCatalogData: medicineCatalogData,
        currentTapIndex: currentTapIndex,
        shippingAddress: shippingAddress,
      );

  QuickOrderPassed quickOrderPassed() => QuickOrderPassed(
        medicineCatalogData: medicineCatalogData,
        currentTapIndex: currentTapIndex,
        shippingAddress: shippingAddress,
      );

  PassQuickOrderFailed quickOrderFailed() => PassQuickOrderFailed(
        medicineCatalogData: medicineCatalogData,
        currentTapIndex: currentTapIndex,
        shippingAddress: shippingAddress,
      );
}

// ------------------ States ------------------

final class MedicineDetailsInitial extends MedicineDetailsState {
  const MedicineDetailsInitial({
    super.medicineCatalogData,
    super.currentTapIndex,
    super.shippingAddress,
  });
}

final class MedicineDetailsLoading extends MedicineDetailsState {
  const MedicineDetailsLoading({
    super.medicineCatalogData,
    super.currentTapIndex,
    super.shippingAddress,
  });
}

final class MedicineDetailsLoaded extends MedicineDetailsState {
  const MedicineDetailsLoaded({
    required super.medicineCatalogData,
    super.currentTapIndex,
    super.shippingAddress,
  });
}

final class MedicineDetailsLoadError extends MedicineDetailsState {
  const MedicineDetailsLoadError({
    super.medicineCatalogData,
    super.currentTapIndex,
    super.shippingAddress,
  });
}

final class MedicineDetailsTapIndexChanged extends MedicineDetailsState {
  const MedicineDetailsTapIndexChanged({
    required super.currentTapIndex,
    super.medicineCatalogData,
    super.shippingAddress,
  });
}

final class MedicineQuantityChanged extends MedicineDetailsState {
  const MedicineQuantityChanged({
    required super.medicineCatalogData,
    super.currentTapIndex,
    super.shippingAddress,
  });
}

final class PassingQuickOrder extends MedicineDetailsState {
  const PassingQuickOrder({
    super.medicineCatalogData,
    super.currentTapIndex,
    super.shippingAddress,
  });
}

final class QuickOrderPassed extends MedicineDetailsState {
  const QuickOrderPassed({
    super.medicineCatalogData,
    super.currentTapIndex,
    super.shippingAddress,
  });
}

final class PassQuickOrderFailed extends MedicineDetailsState {
  const PassQuickOrderFailed({
    super.medicineCatalogData,
    super.currentTapIndex,
    super.shippingAddress,
  });
}
