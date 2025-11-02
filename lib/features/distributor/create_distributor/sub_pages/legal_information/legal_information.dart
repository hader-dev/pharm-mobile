import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/cubit/create_company_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';

class DistributorLegalInformationPage extends StatefulWidget {
  const DistributorLegalInformationPage({super.key});

  @override
  State<DistributorLegalInformationPage> createState() =>
      _DistributorLegalInformationPageState();
}

class _DistributorLegalInformationPageState
    extends State<DistributorLegalInformationPage>
    with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p8),
      child: Scrollbar(
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.responsiveAppSizeTheme.current.p8),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: BlocProvider.of<CreateCompanyProfileCubit>(context)
                  .formKeys[1],
              child: Column(
                children: [
                  CustomTextField(
                    label: '${translation.bank_account}*',
                    value: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .bankAccount,
                    state: FieldState.normal,
                    validationFunc: (value) =>
                        validateIsNumber(value, translation),
                    onChanged: (newValue) {
                      BlocProvider.of<CreateCompanyProfileCubit>(context)
                          .changeCompanyData(
                              modifiedData:
                                  BlocProvider.of<CreateCompanyProfileCubit>(
                                          context)
                                      .companyData
                                      .copyWith(bankAccount: newValue));
                    },
                  ),
                  CustomTextField(
                    label: '${translation.nis} (${translation.nis_expanded})',
                    value: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .nis,
                    state: FieldState.normal,
                    validationFunc: (value) =>
                        emptyValidator(value, translation),
                    onChanged: (newValue) {
                      BlocProvider.of<CreateCompanyProfileCubit>(context)
                          .changeCompanyData(
                              modifiedData:
                                  BlocProvider.of<CreateCompanyProfileCubit>(
                                          context)
                                      .companyData
                                      .copyWith(nis: newValue));
                    },
                  ),
                  CustomTextField(
                    label: '${translation.rc} (${translation.rc_expanded})',
                    value: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .rc,
                    state: FieldState.normal,
                    validationFunc: (value) =>
                        emptyValidator(value, translation),
                    onChanged: (newValue) {
                      BlocProvider.of<CreateCompanyProfileCubit>(context)
                          .changeCompanyData(
                              modifiedData:
                                  BlocProvider.of<CreateCompanyProfileCubit>(
                                          context)
                                      .companyData
                                      .copyWith(rc: newValue));
                    },
                  ),
                  CustomTextField(
                    label: translation.fiscal_id,
                    value: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .fiscalId,
                    state: FieldState.normal,
                    validationFunc: (value) =>
                        emptyValidator(value, translation),
                    onChanged: (newValue) {
                      BlocProvider.of<CreateCompanyProfileCubit>(context)
                          .changeCompanyData(
                              modifiedData:
                                  BlocProvider.of<CreateCompanyProfileCubit>(
                                          context)
                                      .companyData
                                      .copyWith(fiscalId: newValue));
                    },
                  ),
                  CustomTextField(
                    label: '${translation.ai} (${translation.ai_expanded})',
                    state: FieldState.normal,
                    validationFunc: (value) =>
                        emptyValidator(value, translation),
                    value: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .ai,
                    onChanged: (newValue) {
                      BlocProvider.of<CreateCompanyProfileCubit>(context)
                          .changeCompanyData(
                              modifiedData:
                                  BlocProvider.of<CreateCompanyProfileCubit>(
                                          context)
                                      .companyData
                                      .copyWith(ai: newValue));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
