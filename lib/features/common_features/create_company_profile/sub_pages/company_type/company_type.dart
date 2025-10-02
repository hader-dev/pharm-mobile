import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/cubit/create_company_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'widgets/type_card.dart';

class CompanyTypePage extends StatelessWidget {
  const CompanyTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    final supportedCompanyTypes = [
      CompanyType.Pharmacy,
      CompanyType.Other,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: BlocBuilder<CreateCompanyProfileCubit, CreateCompanyProfileState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: supportedCompanyTypes.length,
            itemBuilder: (ctx, idx) => TypeCard(
              title:
                  supportedCompanyTypes[idx].displayName(context.translation!),
              index: supportedCompanyTypes[idx].id,
              subtitle: idx == 1
                  ? context.translation!.other_company_type_description
                  : null,
              selectedTypeIndex:
                  BlocProvider.of<CreateCompanyProfileCubit>(context)
                      .companyData
                      .companyType,
              imagePath: supportedCompanyTypes[idx].imgPath,
              onTap: () {
                BlocProvider.of<CreateCompanyProfileCubit>(context)
                    .changeCompanyData(
                  modifiedData:
                      BlocProvider.of<CreateCompanyProfileCubit>(context)
                          .companyData
                          .copyWith(
                            companyType: supportedCompanyTypes[idx].id,
                          ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
