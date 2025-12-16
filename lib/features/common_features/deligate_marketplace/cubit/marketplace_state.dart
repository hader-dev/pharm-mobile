import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';

class DeligateMarketplaceState {
  final int pageIndex;
  final DelegateClient client;
  final List<DeligateParahparmOrderItemUi> orderProducts;

  const DeligateMarketplaceState({required this.pageIndex, required this.client, this.orderProducts = const []});

  DeligateMarketplacePageChanged toPageChanged({required int pageIndex}) =>
      DeligateMarketplacePageChanged.fromState(state: this, pageIndex: pageIndex);
}

class DeligateMarketplaceInitial extends DeligateMarketplaceState {
  const DeligateMarketplaceInitial({
    required super.client,
  }) : super(pageIndex: 0);
}

class DeligateMarketplacePageChanged extends DeligateMarketplaceState {
  DeligateMarketplacePageChanged.fromState({
    required DeligateMarketplaceState state,
    required super.pageIndex,
  }) : super(client: state.client, orderProducts: state.orderProducts);
}

class DeligateOrderProductsUpdated extends DeligateMarketplaceState {
  DeligateOrderProductsUpdated.fromState({required DeligateMarketplaceState state, required super.orderProducts})
      : super(
          pageIndex: state.pageIndex,
          client: state.client,
        );
}
