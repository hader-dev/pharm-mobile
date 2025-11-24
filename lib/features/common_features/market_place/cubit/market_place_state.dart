part of 'market_place_cubit.dart';

sealed class MarketPlaceState {
  final int pageIndex;

  const MarketPlaceState({this.pageIndex = 0});
}

final class MarketPlaceInitial extends MarketPlaceState {
  const MarketPlaceInitial({super.pageIndex = 0});
}

final class MarketPlaceTapIndexChanged extends MarketPlaceState {
  MarketPlaceTapIndexChanged({required super.pageIndex});
}
