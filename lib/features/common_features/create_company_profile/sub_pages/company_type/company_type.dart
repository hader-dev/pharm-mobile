import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/cubit/create_company_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

import 'widgets/type_card.dart';

class CompanyTypePage extends StatelessWidget {
  const CompanyTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: CompanyType.values
              .map(
                (type) => BlocBuilder<CreateCompanyProfileCubit,
                    CreateCompanyProfileState>(
                  builder: (context, state) {
                    return TypeCard(
                      title: type.name,
                      index: type.id,
                      selectedTypeIndex:
                          BlocProvider.of<CreateCompanyProfileCubit>(context)
                              .companyData
                              .companyType,
                      imagePath: type.imgPath,
                      onTap: () {
                        BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .changeCompanyData(
                          modifiedData:
                              BlocProvider.of<CreateCompanyProfileCubit>(
                                      context)
                                  .companyData
                                  .copyWith(
                                    companyType: type.id,
                                  ),
                        );
                      },
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
