import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/actions/cancel_order.dart'
    show cancelOrder;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/cubit/order_details/orders_details_cubit.dart'
    show DelegateOrderDetails2Cubit;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/delegate_orders_details.dart'
    show DelegateOrdersDetailsScreen;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart' show AppColors, SystemColors;
import '../../../common/buttons/solid/primary_text_button.dart' show PrimaryTextButton;
import '../../../common/spacers/responsive_gap.dart' show ResponsiveGap;
import '../../../common/text_fields/custom_text_field.dart' show CustomTextField;
import '../../../common/widgets/info_widget.dart' show InfoWidget;

class DelegateCancelOrderBottomSheet extends StatelessWidget {
  final TextEditingController _reasonController = TextEditingController();
  DelegateCancelOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit =
        DelegateOrdersDetailsScreen.delegateOrdersDetailsScaffoldKey.currentContext!.read<DelegateOrderDetails2Cubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(translation.are_you_sure_cancel_order, style: context.responsiveTextTheme.current.body1Medium),
        const ResponsiveGap.s16(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
          child: PrimaryTextButton(
            label: context.translation!.confirm,
            onTap: () => cancelOrder(
              context,
              cubit,
            ),
            color: SystemColors.red.primary,
          ),
        ),
        const ResponsiveGap.s12(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
          child: PrimaryTextButton(
            label: translation.cancel,
            labelColor: AppColors.accent1Shade1,
            borderColor: AppColors.accent1Shade1,
            isOutLined: true,
            onTap: () {
              context.pop();
            },
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
