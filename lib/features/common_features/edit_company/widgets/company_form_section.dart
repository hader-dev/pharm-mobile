import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/cubit/edit_company_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CompanyFormSection extends StatefulWidget {
  const CompanyFormSection({super.key});

  @override
  State<CompanyFormSection> createState() => _CompanyFormSectionState();
}

class _CompanyFormSectionState extends State<CompanyFormSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCompanyCubit, EditCompanyState>(
      builder: (context, state) {
        return Form(
          child: Builder(builder: (context) {
            return Column(
              children: [
                CustomTextField(
                  label: '${context.translation!.company_name}*',
                  initValue: BlocProvider.of<EditCompanyCubit>(context)
                      .formData
                      .companyName,
                  state: FieldState.normal,
                  onChanged: (newValue) {
                    BlocProvider.of<EditCompanyCubit>(context).changeFormData(
                        modifiedData: BlocProvider.of<EditCompanyCubit>(context)
                            .formData
                            .copyWith(
                              companyName: newValue,
                            ));
                  },
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return context.translation!.feedback_field_required;
                    }
                    return null;
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: '${context.translation!.email}*',
                  initValue:
                      BlocProvider.of<EditCompanyCubit>(context).formData.email,
                  state: FieldState.normal,
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return context.translation!.feedback_field_required;
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return context.translation!.feedback_invalid_email_format;
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    BlocProvider.of<EditCompanyCubit>(context).changeFormData(
                        modifiedData: BlocProvider.of<EditCompanyCubit>(context)
                            .formData
                            .copyWith(
                              email: newValue,
                            ));
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: context.translation!.full_address,
                  initValue: BlocProvider.of<EditCompanyCubit>(context)
                      .formData
                      .address,
                  state: FieldState.normal,
                  onChanged: (newValue) {
                    BlocProvider.of<EditCompanyCubit>(context).changeFormData(
                        modifiedData: BlocProvider.of<EditCompanyCubit>(context)
                            .formData
                            .copyWith(
                              address: newValue,
                            ));
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: context.translation!.phone_mobile,
                  state: FieldState.normal,
                  initValue:
                      BlocProvider.of<EditCompanyCubit>(context).formData.phone,
                  keyBoadType: TextInputType.phone,
                  onChanged: (newValue) {
                    BlocProvider.of<EditCompanyCubit>(context).changeFormData(
                        modifiedData: BlocProvider.of<EditCompanyCubit>(context)
                            .formData
                            .copyWith(
                              phone: newValue,
                            ));
                  },
                  validationFunc: (value) {
                    return null;
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: context.translation!.phone_2,
                  state: FieldState.normal,
                  initValue: BlocProvider.of<EditCompanyCubit>(context)
                      .formData
                      .phone2,
                  keyBoadType: TextInputType.phone,
                  onChanged: (newValue) {
                    BlocProvider.of<EditCompanyCubit>(context).changeFormData(
                        modifiedData: BlocProvider.of<EditCompanyCubit>(context)
                            .formData
                            .copyWith(
                              phone2: newValue,
                            ));
                  },
                  validationFunc: (value) {
                    return null;
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: context.translation!.fax,
                  state: FieldState.normal,
                  initValue:
                      BlocProvider.of<EditCompanyCubit>(context).formData.fax,
                  keyBoadType: TextInputType.phone,
                  onChanged: (newValue) {
                    BlocProvider.of<EditCompanyCubit>(context).changeFormData(
                        modifiedData: BlocProvider.of<EditCompanyCubit>(context)
                            .formData
                            .copyWith(
                              fax: newValue,
                            ));
                  },
                  validationFunc: (value) {
                    return null;
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: context.translation!.website,
                  state: FieldState.normal,
                  initValue: BlocProvider.of<EditCompanyCubit>(context)
                      .formData
                      .website,
                  onChanged: (newValue) {
                    BlocProvider.of<EditCompanyCubit>(context).changeFormData(
                        modifiedData: BlocProvider.of<EditCompanyCubit>(context)
                            .formData
                            .copyWith(
                              website: newValue,
                            ));
                  },
                  validationFunc: (value) {
                    return null;
                  },
                ),
                Gap(AppSizesManager.s4),
                CustomTextField(
                  label: context.translation!.description,
                  state: FieldState.normal,
                  maxLines: 4,
                  initValue: BlocProvider.of<EditCompanyCubit>(context)
                      .formData
                      .description,
                  onChanged: (newValue) {
                    BlocProvider.of<EditCompanyCubit>(context).changeFormData(
                        modifiedData: BlocProvider.of<EditCompanyCubit>(context)
                            .formData
                            .copyWith(
                              description: newValue,
                            ));
                  },
                  validationFunc: (value) {
                    return null;
                  },
                ),
                Gap(AppSizesManager.s24),
                PrimaryTextButton(
                  label: context.translation!.update_company,
                  isLoading: context.watch<EditCompanyCubit>().state
                      is EditCompanyLoading,
                  onTap: () {
                    if (!Form.of(context).validate()) {
                      return;
                    }

                    BlocProvider.of<EditCompanyCubit>(context).updateCompany(
                        BlocProvider.of<EditCompanyCubit>(context).formData,
                        context.translation!);
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
