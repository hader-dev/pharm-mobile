import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart' show ResponsiveGap;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderPlacedSuccessfullyDialog extends StatelessWidget {
  const OrderPlacedSuccessfullyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return Container(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 64),
          ResponsiveGap.s16(),
          Text(
            translation.order_placed_successfully,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ResponsiveGap.s8(),
          Text(
            translation.thank_you_purchase,
            textAlign: TextAlign.center,
          ),
          ResponsiveGap.s24(),
          Column(
            children: [
              PrimaryTextButton(
                  label: translation.continue_shopping,
                  labelColor: AppColors.bgWhite,
                  color: AppColors.accent1Shade1,
                  labelTextStyle: context.responsiveTextTheme.current.body3Medium.copyWith(color: AppColors.bgWhite),
                  onTap: () async {
                    context.pop();
                    AppLayout.appLayoutScaffoldKey.currentContext!.read<AppLayoutCubit>().changePage(1);
                  }),
              ResponsiveGap.s8(),
              PrimaryTextButton(
                  label: translation.view_order,
                  labelColor: AppColors.accent1Shade1,
                  isOutLined: true,
                  borderColor: AppColors.bgDisabled,
                  labelTextStyle:
                      context.responsiveTextTheme.current.body3Medium.copyWith(color: AppColors.accent1Shade1),
                  onTap: () {
                    context.pop();
                    AppLayout.appLayoutScaffoldKey.currentContext!.read<AppLayoutCubit>().changePage(3);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
