import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/text_fields/custom_text_field.dart';
import '../../cubit/create_company_profile_cubit.dart';

class GeneralInformationPage extends StatefulWidget {
  const GeneralInformationPage({super.key});

  @override
  State<GeneralInformationPage> createState() => _GeneralInformationPageState();
}

class _GeneralInformationPageState extends State<GeneralInformationPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<CreateCompanyProfileCubit, CreateCompanyProfileState>(
          builder: (context, state) {
            return Column(
              children: [
                CustomTextField(
                  label: 'Company Name',
                  value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.companyName,
                  state: FieldState.normal,
                  validationFunc: () {},
                  onChanged: (newValue) {
                    BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                        modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .copyWith(companyName: newValue));
                  },
                ),
                CustomTextField(
                  label: 'Wilaya (Province)',
                  value: ' BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.',
                  state: FieldState.normal,
                  validationFunc: () {},
                ),
                CustomTextField(
                  label: 'City/Commune',
                  value: '',
                  state: FieldState.normal,
                  validationFunc: () {},
                ),
                CustomTextField(
                  label: 'Full Address',
                  value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.fullAddress,
                  state: FieldState.normal,
                  validationFunc: () {},
                  onChanged: (newValue) {
                    BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                        modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .copyWith(fullAddress: newValue));
                  },
                ),
                CustomTextField(
                  label: 'Website (Optional)',
                  value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.website,
                  state: FieldState.normal,
                  validationFunc: () {},
                  onChanged: (newValue) {
                    BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                        modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .copyWith(website: newValue));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
