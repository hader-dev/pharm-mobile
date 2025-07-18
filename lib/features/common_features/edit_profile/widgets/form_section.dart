import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

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
                  label: 'Full Name*',
                  initValue: BlocProvider.of<EditProfileCubit>(context).profileData.fullName,
                  state: FieldState.normal,
                  onChanged: (newValue) {
                    BlocProvider.of<EditProfileCubit>(context).changeProfileData(
                        modifiedData: BlocProvider.of<EditProfileCubit>(context).profileData.copyWith(
                              fullName: newValue,
                            ));
                  },
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full Name is required';
                    }
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: 'Email*',
                  initValue: BlocProvider.of<EditProfileCubit>(context).profileData.email,
                  state: FieldState.normal,
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return 'Email is not valid';
                    }
                  },
                  onChanged: (newValue) {
                    BlocProvider.of<EditProfileCubit>(context).changeProfileData(
                        modifiedData: BlocProvider.of<EditProfileCubit>(context).profileData.copyWith(
                              email: newValue,
                            ));
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: 'Phone Number',
                  state: FieldState.normal,
                  initValue: BlocProvider.of<EditProfileCubit>(context).profileData.phone,
                  keyBoadType: TextInputType.phone,
                  onChanged: (newValue) {
                    BlocProvider.of<EditProfileCubit>(context).changeProfileData(
                        modifiedData: BlocProvider.of<EditProfileCubit>(context).profileData.copyWith(
                              phone: newValue,
                            ));
                  },
                  validationFunc: (value) {
                    return;
                  },
                ),
                Gap(AppSizesManager.s24),
                PrimaryTextButton(
                  label: "Update Profile",
                  isLoading: context.watch<EditProfileCubit>().state is EditProfileLoading,
                  onTap: () {
                    if (!Form.of(context).validate()) {
                      return;
                    }

                    BlocProvider.of<EditProfileCubit>(context)
                        .editProfile(BlocProvider.of<EditProfileCubit>(context).profileData);
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
