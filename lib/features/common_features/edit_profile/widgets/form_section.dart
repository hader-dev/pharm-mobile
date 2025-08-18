import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/text_fields/custom_text_field.dart';
import '../cubit/edit_profile_cubit.dart';

class FormSection extends StatefulWidget {
  const FormSection({super.key});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return Form(
          child: Builder(builder: (context) {
            return Column(
              children: [
                CustomTextField(
                  label: '${context.translation!.full_name}*',
                  initValue: BlocProvider.of<EditProfileCubit>(context)
                      .profileData
                      .fullName,
                  state: FieldState.normal,
                  onChanged: (newValue) {
                    BlocProvider.of<EditProfileCubit>(context)
                        .changeProfileData(
                            modifiedData:
                                BlocProvider.of<EditProfileCubit>(context)
                                    .profileData
                                    .copyWith(
                                      fullName: newValue,
                                    ));
                  },
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return context.translation!.feedback_field_required;
                    }
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: '${context.translation!.email}*',
                  initValue: BlocProvider.of<EditProfileCubit>(context)
                      .profileData
                      .email,
                  state: FieldState.normal,
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return context.translation!.feedback_field_required;
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return context.translation!.feedback_invalid_email_format;
                    }
                  },
                  onChanged: (newValue) {
                    BlocProvider.of<EditProfileCubit>(context)
                        .changeProfileData(
                            modifiedData:
                                BlocProvider.of<EditProfileCubit>(context)
                                    .profileData
                                    .copyWith(
                                      email: newValue,
                                    ));
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: '${context.translation!.shipping_address}*',
                  initValue: BlocProvider.of<EditProfileCubit>(context)
                      .profileData
                      .address,
                  state: FieldState.normal,
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return context.translation!.feedback_field_required;
                    }
                  },
                  onChanged: (newValue) {
                    BlocProvider.of<EditProfileCubit>(context)
                        .changeProfileData(
                            modifiedData:
                                BlocProvider.of<EditProfileCubit>(context)
                                    .profileData
                                    .copyWith(
                                      address: newValue,
                                    ));
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: context.translation!.phone_mobile,
                  state: FieldState.normal,
                  initValue: BlocProvider.of<EditProfileCubit>(context)
                      .profileData
                      .phone,
                  keyBoadType: TextInputType.phone,
                  onChanged: (newValue) {
                    BlocProvider.of<EditProfileCubit>(context)
                        .changeProfileData(
                            modifiedData:
                                BlocProvider.of<EditProfileCubit>(context)
                                    .profileData
                                    .copyWith(
                                      phone: newValue,
                                    ));
                  },
                  validationFunc: (value) {
                    return;
                  },
                ),
                Gap(AppSizesManager.s24),
                PrimaryTextButton(
                  label: context.translation!.update_profile,
                  isLoading: context.watch<EditProfileCubit>().state
                      is EditProfileLoading,
                  onTap: () {
                    if (!Form.of(context).validate()) {
                      return;
                    }

                    BlocProvider.of<EditProfileCubit>(context).editProfile(
                        BlocProvider.of<EditProfileCubit>(context).profileData);
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
