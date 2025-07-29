import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../../utils/constants.dart';
import '../../../../common/text_fields/custom_text_field.dart';
import '../../../../common_features/create_company_profile/cubit/create_company_profile_cubit.dart';

class DistributorLegalInformationPage extends StatefulWidget {
  const DistributorLegalInformationPage({super.key});

  @override
  State<DistributorLegalInformationPage> createState() => _DistributorLegalInformationPageState();
}

class _DistributorLegalInformationPageState extends State<DistributorLegalInformationPage>
    with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                          label: 'Bank Account*',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.bankAccount,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "${context.translation!.errors_field_required} ";
                            }
                          },
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(bankAccount: newValue));
                          },
                        ),
                        CustomTextField(
                          label: 'NIS* (Static Identification Number)',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.nis,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "${context.translation!.errors_field_required} ";
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
                              return "${context.translation!.errors_field_required} ";
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
                          label: 'Fiscal Id*',
                          value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.fiscalId,
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "${context.translation!.errors_field_required} ";
                            }
                          },
                          onChanged: (newValue) {
                            BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                                modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                    .companyData
                                    .copyWith(fiscalId: newValue));
                          },
                        ),
                        CustomTextField(
                          label: 'AI*',
                          state: FieldState.normal,
                          validationFunc: (value) {
                            if (value == null || value.isEmpty) {
                              return "${context.translation!.errors_field_required} ";
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
