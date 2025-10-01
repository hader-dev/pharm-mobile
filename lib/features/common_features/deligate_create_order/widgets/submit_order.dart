import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class DeligateOrderSubmit extends StatelessWidget {
  const DeligateOrderSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<DeligateCreateOrderCubit>();

    return Padding(
      padding: const EdgeInsets.all(AppSizesManager.p8),
      child: PrimaryTextButton(
        label: translation.make_order,
        onTap: cubit.submitOrder,
        color: AppColors.accent1Shade1,
        labelColor: AppColors.bgWhite,
      ),
    );
  }
}
