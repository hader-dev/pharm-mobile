import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/cubit/create_company_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class PharmacyLegalInformationPage extends StatefulWidget {
  const PharmacyLegalInformationPage({super.key});

  @override
  State<PharmacyLegalInformationPage> createState() =>
      _PharmacyLegalInformationPageState();
}

class _PharmacyLegalInformationPageState
    extends State<PharmacyLegalInformationPage>
    with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
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
                    label: context.translation!.nis,
                    value: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .nis,
                    state: FieldState.normal,
                    validationFunc: (value) {
                      return;
                    },
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
                    label: context.translation!.rc,
                    value: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .rc,
                    state: FieldState.normal,
                    validationFunc: (value) {
                      return;
                    },
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
                    label: context.translation!.ai,
                    state: FieldState.normal,
                    validationFunc: (value) {
                      return;
                    },
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
