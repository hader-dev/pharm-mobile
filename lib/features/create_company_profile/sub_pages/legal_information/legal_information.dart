import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/text_fields/custom_text_field.dart';
import '../../cubit/create_company_profile_cubit.dart';

class LegalInformationPage extends StatefulWidget {
  const LegalInformationPage({super.key});

  @override
  State<LegalInformationPage> createState() => _LegalInformationPageState();
}

class _LegalInformationPageState extends State<LegalInformationPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomTextField(
              label: 'NIF (Tax Identification Number)',
              value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.nif,
              state: FieldState.normal,
              validationFunc: () {},
              onChanged: (newValue) {
                BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                    modifiedData:
                        BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.copyWith(nif: newValue));
              },
            ),
            CustomTextField(
              label: 'NIS (Static Indentification Number)',
              value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.nis,
              state: FieldState.normal,
              validationFunc: () {},
              onChanged: (newValue) {
                BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                    modifiedData:
                        BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.copyWith(nis: newValue));
              },
            ),
            CustomTextField(
              label: 'Commercial Registration Number (RC)',
              value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.commercialRegNumber,
              state: FieldState.normal,
              validationFunc: () {},
              onChanged: (newValue) {
                BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                    modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .copyWith(commercialRegNumber: newValue));
              },
            ),
            CustomTextField(
              label: 'Credit Limit (numeric)',
              value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.creditLimit.toString(),
              state: FieldState.normal,
              validationFunc: () {},
              onChanged: (newValue) {
                BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                    modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .copyWith(creditLimit: newValue));
              },
            ),
            CustomTextField(
              label: 'AI (text)',
              state: FieldState.normal,
              validationFunc: () {},
              value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.ai,
              onChanged: (newValue) {
                BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                    modifiedData:
                        BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.copyWith(ai: newValue));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
