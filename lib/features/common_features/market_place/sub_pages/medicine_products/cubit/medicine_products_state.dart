part of 'medicine_products_cubit.dart';

sealed class MedicineProductsState {}

final class MedicineProductsInitial extends MedicineProductsState {}

// Medicine products states

final class MedicineProductsLoading extends MedicineProductsState {}

final class LoadingMoreMedicine extends MedicineProductsState {}

final class MedicineProductsLoaded extends MedicineProductsState {}

final class MedicineProductsLoadingFailed extends MedicineProductsState {}

//Search Limit Reached State :
final class MedicinesLoadLimitReached extends MedicineProductsState {}
