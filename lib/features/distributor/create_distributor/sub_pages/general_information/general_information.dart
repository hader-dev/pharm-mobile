import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/cubit/create_company_profile_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/town.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/wilaya.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';

class DistributorGeneralInformationPage extends StatefulWidget {
  const DistributorGeneralInformationPage({super.key});

  @override
  State<DistributorGeneralInformationPage> createState() =>
      _DistributorGeneralInformationPageState();
}

class _DistributorGeneralInformationPageState
    extends State<DistributorGeneralInformationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final translation = context.translation!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
      child: Scrollbar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<CreateCompanyProfileCubit,
                CreateCompanyProfileState>(
              builder: (context, state) {
                return Form(
                    key: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .formKeys[0],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppSizesManager.p4,
                              top: AppSizesManager.p8),
                          child: Text("${translation.what_you_distribute}*",
                              style: context.responsiveTextTheme.current.body3Medium
                                  .copyWith(color: TextColors.ternary.color)),
                        ),
                        DropdownButtonFormField(
                            initialValue: BlocProvider.of<CreateCompanyProfileCubit>(
                                    context)
                                .companyData
                                .distributorCategoryId,
                            hint: Text(translation.select_category,
                                style: context.responsiveTextTheme.current.body3Regular
                                    .copyWith(color: TextColors.ternary.color)),
                            validator: (value) {
                              if (value == null) {
                                return context
                                    .translation!.feedback_field_required;
                              }
                              return null;
                            },
                            elevation: 0,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.accent1Shade1,
                            ),
                            padding:
                                const EdgeInsets.only(left: AppSizesManager.p4),
                            isDense: true,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppSizesManager.commonWidgetsRadius),
                                borderSide:
                                    BorderSide(color: AppColors.bgDisabled),
                              ),
                              focusedBorder: InputBorder.none,
                            ),
                            items: DistributorCategory.values
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                            onChanged: (newValue) {
                              BlocProvider.of<CreateCompanyProfileCubit>(
                                      context)
                                  .changeCompanyData(
                                      modifiedData: BlocProvider.of<
                                                  CreateCompanyProfileCubit>(
                                              context)
                                          .companyData
                                          .copyWith(
                                              distributorCategoryId: newValue));
                            }),
                        const Gap(AppSizesManager.s6),
                        CustomTextField(
                          label: "${translation.company_name}*",
                          value: BlocProvider.of<CreateCompanyProfileCubit>(
                                  context)
                              .companyData
                              .companyName,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return translation.feedback_field_required;
                            }
                          },
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context)
                                .changeCompanyData(
                                    modifiedData: BlocProvider.of<
                                            CreateCompanyProfileCubit>(context)
                                        .companyData
                                        .copyWith(companyName: newValue));
                          },
                        ),
                        CustomTextField(
                          label: translation.email,
                          value: BlocProvider.of<CreateCompanyProfileCubit>(
                                  context)
                              .companyData
                              .email,
                          state: FieldState.normal,
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context)
                                .changeCompanyData(
                                    modifiedData: BlocProvider.of<
                                            CreateCompanyProfileCubit>(context)
                                        .companyData
                                        .copyWith(email: newValue));
                          },
                          validationFunc: (value) =>
                              validateIsEmail(value, translation, true),
                        ),
                        CustomTextField(
                          label: translation.phone_number,
                          value: BlocProvider.of<CreateCompanyProfileCubit>(
                                  context)
                              .companyData
                              .phone,
                          state: FieldState.normal,
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context)
                                .changeCompanyData(
                                    modifiedData: BlocProvider.of<
                                            CreateCompanyProfileCubit>(context)
                                        .companyData
                                        .copyWith(phone: newValue));
                          },
                          validationFunc: (value) =>
                              validateIsMobileNumber(value, translation),
                        ),
                        CustomTextField(
                          label: translation.fax,
                          value: BlocProvider.of<CreateCompanyProfileCubit>(
                                  context)
                              .companyData
                              .fax,
                          state: FieldState.normal,
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context)
                                .changeCompanyData(
                                    modifiedData: BlocProvider.of<
                                            CreateCompanyProfileCubit>(context)
                                        .companyData
                                        .copyWith(fax: newValue));
                          },
                          validationFunc: (value) =>
                              validateIsFaxNumber(value, translation),
                        ),
                        CustomTextField(
                          label: translation.full_address,
                          value: BlocProvider.of<CreateCompanyProfileCubit>(
                                  context)
                              .companyData
                              .fullAddress,
                          state: FieldState.normal,
                          validationFunc: (value) =>
                              emptyValidator(value, translation),
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context)
                                .changeCompanyData(
                                    modifiedData: BlocProvider.of<
                                            CreateCompanyProfileCubit>(context)
                                        .companyData
                                        .copyWith(fullAddress: newValue));
                          },
                        ),
                        CustomTextField(
                          label: translation.website,
                          value: BlocProvider.of<CreateCompanyProfileCubit>(
                                  context)
                              .companyData
                              .website,
                          state: FieldState.normal,
                          validationFunc: (value) =>
                              emptyValidator(value, translation),
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context)
                                .changeCompanyData(
                                    modifiedData: BlocProvider.of<
                                            CreateCompanyProfileCubit>(context)
                                        .companyData
                                        .copyWith(website: newValue));
                          },
                        ),
                        WilayaDropdown(),
                        TownDropdown(
                            isRequired: true,
                            validator: (v) => requiredValidator(v?.label, translation),
                            onChanged: (newValue) {
                              if (newValue == null) return;
                              BlocProvider.of<CreateCompanyProfileCubit>(
                                      context)
                                  .changeCompanyData(
                                modifiedData:
                                    BlocProvider.of<CreateCompanyProfileCubit>(
                                            context)
                                        .companyData
                                        .copyWith(
                                          townId: newValue.id,
                                        ),
                              );
                            }),
                      ],
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
