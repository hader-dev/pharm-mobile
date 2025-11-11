import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/cubit/edit_company_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';

class CompanyFormSection extends StatefulWidget {
  const CompanyFormSection({super.key, required this.isEditable});
  final bool isEditable;

  @override
  State<CompanyFormSection> createState() => _CompanyFormSectionState();
}

class _CompanyFormSectionState extends State<CompanyFormSection> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditCompanyCubit>();

    final translation = context.translation!;

    return BlocBuilder<EditCompanyCubit, EditCompanyState>(
      builder: (context, state) {
        return Form(
          key: cubit.formKey,
          child: Builder(builder: (context) {
            return Column(
              children: [
                CustomTextField(
                    label: '${context.translation!.company_name}*',
                    initValue: state.formData.companyName,
                    state: FieldState.normal,
                    onChanged: (newValue) {
                      cubit.changeFormData(
                          modifiedData: state.formData.copyWith(
                        companyName: newValue,
                      ));
                    },
                    validationFunc: (v) => requiredValidator(v, translation)),
                const ResponsiveGap.s4(),
                CustomTextField(
                  label: '${context.translation!.email}*',
                  initValue: state.formData.email,
                  state: FieldState.normal,
                  validationFunc: (v) => validateIsEmail(v, translation, true),
                  onChanged: (newValue) {
                    cubit.changeFormData(
                        modifiedData: state.formData.copyWith(
                      email: newValue,
                    ));
                  },
                ),
                const ResponsiveGap.s4(),
                CustomTextField(
                  label: "${context.translation!.full_address}*",
                  initValue: state.formData.address,
                  state: FieldState.normal,
                  validationFunc: (v) => requiredValidator(v, translation),
                  onChanged: (newValue) {
                    cubit.changeFormData(
                        modifiedData: state.formData.copyWith(
                      address: newValue,
                    ));
                  },
                ),
                const ResponsiveGap.s4(),
                CustomTextField(
                  label: "${context.translation!.phone_mobile}*",
                  state: FieldState.normal,
                  initValue: state.formData.phone,
                  keyBoadType: TextInputType.phone,
                  validationFunc: (v) =>
                      validateIsMobileNumber(v, translation, true),
                  onChanged: (newValue) {
                    cubit.changeFormData(
                        modifiedData: state.formData.copyWith(
                      phone: newValue,
                    ));
                  },
                ),
                const ResponsiveGap.s4(),
                CustomTextField(
                  label: context.translation!.phone_2,
                  state: FieldState.normal,
                  initValue: state.formData.phone2,
                  keyBoadType: TextInputType.phone,
                  onChanged: (newValue) {
                    cubit.changeFormData(
                        modifiedData: state.formData.copyWith(
                      phone2: newValue,
                    ));
                  },
                  validationFunc: (value) {
                    return null;
                  },
                ),
                const ResponsiveGap.s4(),
                CustomTextField(
                  label: context.translation!.fax,
                  state: FieldState.normal,
                  initValue: state.formData.fax,
                  keyBoadType: TextInputType.phone,
                  onChanged: (newValue) {
                    cubit.changeFormData(
                        modifiedData: state.formData.copyWith(
                      fax: newValue,
                    ));
                  },
                  validationFunc: (value) {
                    return null;
                  },
                ),
                const ResponsiveGap.s4(),
                CustomTextField(
                  label: context.translation!.website,
                  state: FieldState.normal,
                  initValue: state.formData.website,
                  onChanged: (newValue) {
                    cubit.changeFormData(
                        modifiedData: state.formData.copyWith(
                      website: newValue,
                    ));
                  },
                  validationFunc: (value) {
                    return null;
                  },
                ),
                const ResponsiveGap.s4(),
                CustomTextField(
                  label: context.translation!.description,
                  state: FieldState.normal,
                  maxLines: 4,
                  initValue: state.formData.description,
                  onChanged: (newValue) {
                    cubit.changeFormData(
                        modifiedData: state.formData.copyWith(
                      description: newValue,
                    ));
                  },
                  validationFunc: (value) {
                    return null;
                  },
                ),
                const ResponsiveGap.s24(),
                PrimaryTextButton(
                  label: context.translation!.update_company,
                  isLoading: context.watch<EditCompanyCubit>().state
                      is EditCompanyLoading,
                  onTap: () {
                    BlocProvider.of<EditCompanyCubit>(context)
                        .updateCompany(state.formData, context.translation!);
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
