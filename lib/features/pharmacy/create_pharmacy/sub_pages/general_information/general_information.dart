import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/enums.dart';
import '../../../../common/text_fields/custom_text_field.dart';
import '../../../../common_features/create_company_profile/cubit/create_company_profile_cubit.dart';

class PharmacyGeneralInformationPage extends StatefulWidget {
  const PharmacyGeneralInformationPage({super.key});

  @override
  State<PharmacyGeneralInformationPage> createState() => _PharmacyGeneralInformationPageState();
}

class _PharmacyGeneralInformationPageState extends State<PharmacyGeneralInformationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                      children: [
                        CustomTextField(
                          label: 'Company Name*',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.companyName,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return context.translation!.fieldRequired;
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
                          label: 'Email*',
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
                              return context.translation!.fieldRequired;
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
                          keyBoadType: TextInputType.phone,
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
