import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';

class FormSection extends StatefulWidget {
  const FormSection({super.key});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<EditProfileCubit>();

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return Form(
          child: Builder(builder: (context) {
            return Column(
              children: [
                CustomTextField(
                  label: '${context.translation!.full_name}*',
                  initValue: state.profileData.fullName,
                  state: FieldState.normal,
                  onChanged: (newValue) {
                    cubit.changeProfileData(
                        modifiedData: state.profileData.copyWith(
                      fullName: newValue,
                    ));
                  },
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return context.translation!.feedback_field_required;
                    }
                  },
                ),
                const ResponsiveGap.s4(),
                CustomTextField(
                  label: '${context.translation!.email}*',
                  initValue: state.profileData.email,
                  state: FieldState.normal,
                  validationFunc: (value) =>
                      validateIsEmail(value, translation),
                  onChanged: (newValue) {
                    cubit.changeProfileData(
                        modifiedData: state.profileData.copyWith(
                      email: newValue,
                    ));
                  },
                ),
                const ResponsiveGap.s4(),
                CustomTextField(
                  label: context.translation!.phone_mobile,
                  state: FieldState.normal,
                  initValue: state.profileData.phone,
                  keyBoadType: TextInputType.phone,
                  maxLength: 10,
                  onChanged: (newValue) {
                    cubit.changeProfileData(
                        modifiedData: state.profileData.copyWith(
                      phone: newValue,
                    ));
                  },
                  validationFunc: (v) => validateIsMobileNumber(v, translation),
                ),
                const ResponsiveGap.s24(),
                PrimaryTextButton(
                  label: translation.update_profile,
                  isLoading: context.watch<EditProfileCubit>().state
                      is EditProfileLoading,
                  onTap: () {
                    if (!Form.of(context).validate()) {
                      return;
                    }

                    cubit.editProfile(state.profileData);
                  },
                  color: AppColors.accent1Shade1,
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
