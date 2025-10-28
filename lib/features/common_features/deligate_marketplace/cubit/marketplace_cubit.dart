import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/cubit/marketplace_state.dart';
import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/create_deligate_order.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

class DeligateMarketplaceCubit extends Cubit<DeligateMarketplaceState> {
  final IOrderRepository orderRepo;

  DeligateMarketplaceCubit({
    required DeligateClient client,
    required this.orderRepo,
  }) : super(DeligateMarketplaceInitial(
          client: client,
        ));

  void changePage(int pageIndex) {
    emit(state.toPageChanged(pageIndex: pageIndex));
  }

  Future<void> submitOrder() async {
    final context = AppLayout.appLayoutScaffoldKey.currentContext!;
    final translation = context.translation!;
    final messanger = getItInstance.get<ToastManager>();

    if (state.orderProducts.isEmpty || state.client.id.isEmpty) {
      messanger.showToast(
          type: ToastType.error,
          message: translation.feedback_select_client_and_add_items);
      return;
    }

    try {
      final userManager = getItInstance<UserManager>();
      await orderRepo.createDeligateOrder(ParamsCreateDeligateOrder(
        deliveryAddress: userManager.currentUser.address,
        deliveryTownId: userManager.currentUser.townId,
        orderItems: state.orderProducts.map((el) => el.model).toList(),
        clientId: state.client.buyerCompany.managerUserId!,
        clientCompanyId: state.client.buyerCompany.id,
      ));
      messanger.showToast(
          type: ToastType.success,
          message: translation.order_placed_successfully);
    } catch (e) {
      messanger.showToast(
          type: ToastType.error, message: translation.order_placed_failed);
    }
  }
}
