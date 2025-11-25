import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart' show CustomTextField;
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart' show InfoWidget;
import 'package:hader_pharm_mobile/features/common_features/orders_details/actions/cancel_order.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/orders_details.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CancelOrderBottomSheet extends StatelessWidget {
  const CancelOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController reasonController = TextEditingController();
    final translation = context.translation!;
    final cubit = OrdersDetailsScreen.ordersDetailsScaffoldKey.currentContext!.read<OrderDetailsCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(translation.are_you_sure_cancel_order, style: context.responsiveTextTheme.current.body1Medium),
        const ResponsiveGap.s16(),
        InfoWidget(
            label: context.translation!.note,
            bgColor: AppColors.bgWhite,
            value: CustomTextField(
              verticalPadding: 0,
              horizontalPadding: context.responsiveAppSizeTheme.current.p6,
              controller: reasonController,
              maxLines: 2,
              maxLength: 10,
              validationFunc: (value) {},
              isFilled: false,
              isBorderEnabled: true,
              hintText: context.translation!.type_note_hint,
              hintTextStyle: context.responsiveTextTheme.current.bodySmall.copyWith(color: Colors.grey),
            )),
        const ResponsiveGap.s16(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
          child: PrimaryTextButton(
            label: context.translation!.confirm,
            onTap: () => cancelOrder(context, cubit, reasonController.text),
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
