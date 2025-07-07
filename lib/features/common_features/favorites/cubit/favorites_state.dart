part of 'favorites_cubit.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

//Medicines
final class FavoritesMedicinesLoading extends FavoritesState {}

final class FavoritesMedicinesLoaded extends FavoritesState {}

final class FavoritesMedicinesLoadingFailed extends FavoritesState {}

//Para-pharma
final class FavoritesParaPharmaLoading extends FavoritesState {}

final class FavoritesParaPharmaLoaded extends FavoritesState {}

final class FavoritesParaPharmaLoadingFailed extends FavoritesState {}

//Vendors
final class FavoritesVendorsLoading extends FavoritesState {}

final class FavoritesVendorsLoaded extends FavoritesState {}

final class FavoritesVendorsLoadingFailed extends FavoritesState {}
