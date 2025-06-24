import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

import '../../../../../../utils/constants.dart';
import '../../../../../../utils/enums.dart';

import '../../../../../config/theme/typoghrapy_manager.dart';
import '../../../../common/text_fields/custom_text_field.dart';
import '../../../../common_features/create_company_profile/cubit/create_company_profile_cubit.dart'
    show CreateCompanyProfileCubit, CreateCompanyProfileState;

class DistributorGeneralInformationPage extends StatefulWidget {
  const DistributorGeneralInformationPage({super.key});

  @override
  State<DistributorGeneralInformationPage> createState() => _DistributorGeneralInformationPageState();
}

class _DistributorGeneralInformationPageState extends State<DistributorGeneralInformationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
      child: Scrollbar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<CreateCompanyProfileCubit, CreateCompanyProfileState>(
              builder: (context, state) {
                return Form(
                    key: BlocProvider.of<CreateCompanyProfileCubit>(context).formKeys[0],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: AppSizesManager.p4, top: AppSizesManager.p8),
                          child: Text("What you distribute ? *",
                              style: AppTypography.body3MediumStyle.copyWith(color: TextColors.ternary.color)),
                        ),
                        DropdownButtonFormField(
                            value:
                                BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.distributorCategoryId,
                            hint: Text('Select Category ',
                                style: AppTypography.bodySmallStyle.copyWith(color: TextColors.ternary.color)),
                            validator: (value) {
                              if (value == null) {
                                return 'field is required';
                              }
                              return null;
                            },
                            elevation: 0,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.accent1Shade1,
                            ),
                            padding: const EdgeInsets.only(left: AppSizesManager.p4),
                            isDense: true,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                                borderSide: BorderSide(color: AppColors.bgDisabled),
                              ),
                              focusedBorder: InputBorder.none,
                            ),
                            items: DistributorCategory.values
                                .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
                                .toList(),
                            onChanged: (newValue) {
                              BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                  modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                      .companyData
                                      .copyWith(distributorCategoryId: newValue));
                            }),
                        const Gap(AppSizesManager.s6),
                        CustomTextField(
                          label: 'Company Name*',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.companyName,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field is required';
                            }
                          },
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(companyName: newValue));
                          },
                        ),

                        CustomTextField(
                          label: 'Email',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.email,
                          state: FieldState.normal,
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(email: newValue));
                          },
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field is required';
                            }
                            if (!emailRegex.hasMatch(value)) {
                              return 'Email is not valid';
                            }
                          },
                        ),
                        CustomTextField(
                          label: 'Phone Number',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.phone,
                          state: FieldState.normal,
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(phone: newValue));
                          },
                          validationFunc: (value) {
                            return;
                          },
                        ),
                        CustomTextField(
                          label: 'Fax',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.fax,
                          state: FieldState.normal,
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(fax: newValue));
                          },
                          validationFunc: (value) {
                            return;
                          },
                        ),
                        // CustomTextField(
                        //   label: 'City/Commune',
                        //   value: '',
                        //   state: FieldState.normal,
                        //   validationFunc: (value){
                        // return ;},
                        // ),
                        CustomTextField(
                          label: 'Full Address',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.fullAddress,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            return;
                          },
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(fullAddress: newValue));
                          },
                        ),
                        CustomTextField(
                          label: 'Website',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.website,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            return;
                          },
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(website: newValue));
                          },
                        ),
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
