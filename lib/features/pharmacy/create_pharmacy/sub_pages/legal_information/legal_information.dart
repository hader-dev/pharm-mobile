import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

import '../../../../../utils/constants.dart';
import '../../../../common/text_fields/custom_text_field.dart';
import '../../../../common_features/create_company_profile/cubit/create_company_profile_cubit.dart';

class PharmacyLegalInformationPage extends StatefulWidget {
  const PharmacyLegalInformationPage({super.key});

  @override
  State<PharmacyLegalInformationPage> createState() => _PharmacyLegalInformationPageState();
}

class _PharmacyLegalInformationPageState extends State<PharmacyLegalInformationPage>
    with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
        child: Scrollbar(
            controller: scrollController,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: BlocProvider.of<CreateCompanyProfileCubit>(context).formKeys[1],
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'NIS* (Static Identification Number)',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.nis,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "field is required ";
                            }
                          },
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(nis: newValue));
                          },
                        ),
                        CustomTextField(
                          label: 'RC* (Commercial Registration Number)',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.rc,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "field is required ";
                            }
                          },
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(rc: newValue));
                          },
                        ),
                        CustomTextField(
                          label: 'AI*',
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "field is required ";
                            }
                          },
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.ai,
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(ai: newValue));
                          },
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  @override
  bool get wantKeepAlive => true;
}
