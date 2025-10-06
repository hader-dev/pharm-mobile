import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

Future<void> cancelOrder(
    BuildContext context, OrderDetailsCubit orderDetailsCubit) async {
  final appLocalizations = context.translation!;

  await orderDetailsCubit.cancelOrder().then((v) {
    if (context.mounted) {
      context.pop();
    }

    if (v.success && context.mounted) {
      orderDetailsCubit.reloadOrderData();
      final ordersCubit =
          AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>();
      ordersCubit.getOrders();
    }

    final toastType = v.success ? ToastType.success : ToastType.error;
    final message = v.success
        ? appLocalizations.order_cancelled
        : appLocalizations.feedback_server_error;

    ToastManager toastManager = getItInstance.get<ToastManager>();

    toastManager.showToast(message: message, type: toastType);
  });
}
