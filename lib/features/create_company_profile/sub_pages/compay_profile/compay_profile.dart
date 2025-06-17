import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../config/theme/colors_manager.dart';
import '../../../../../config/theme/typoghrapy_manager.dart';
import '../../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/buttons/solid/primary_icon_button.dart';
import '../../../common/text_fields/custom_text_field.dart';
import '../../cubit/create_company_profile_cubit.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({super.key});

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> with AutomaticKeepAliveClientMixin {
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
                Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Text("Logo", style: AppTypography.body3MediumStyle.copyWith(color: TextColors.ternary.color))),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizesManager.p24),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        width: MediaQuery.sizeOf(context).height * 0.3,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.bgDarken,
                            border: Border.all(color: AppColors.bgDarken2)),
                      ),
                      Positioned(
                        bottom: AppSizesManager.s16,
                        right: AppSizesManager.s16,
                        child: PrimaryIconButton(
                          icon: Icon(
                            Iconsax.camera,
                            color: AppColors.bgWhite,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
                Gap(AppSizesManager.s16),
                CustomTextField(
                  label: 'Description',
                  state: FieldState.normal,
                  maxLines: 8,
                  validationFunc: () {},
                  value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.description,
                  onChanged: (newValue) {
                    BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                        modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .copyWith(description: newValue));
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
