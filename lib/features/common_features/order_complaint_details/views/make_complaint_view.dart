import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/actions/make_complaint.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';

class MakeComplaintView extends StatelessWidget {
  const MakeComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    final cubit = context.read<OrderComplaintsCubit>();

    return Form(
      key: cubit.state.complaintFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomTextField(
            label: '${context.translation!.subject}*',
            controller: cubit.state.subjectController,
            maxLength: 35,
            state: FieldState.normal,
            validationFunc: (v) => requiredValidator(v, translation),
          ),
          const ResponsiveGap.s4(),
          CustomTextField(
            label: '${context.translation!.description}*',
            controller: cubit.state.descriptionController,
            state: FieldState.normal,
            maxLines: 5,
            validationFunc: (v) => requiredValidator(v, translation),
          ),
          const ResponsiveGap.s8(),
          PrimaryTextButton(
            label: translation.confirm,
            color: AppColors.accent1Shade1,
            onTap: () => makeComplaint(cubit, cubit.state.complaintFormKey, translation),
          )
        ],
      ),
    );
  }
}
