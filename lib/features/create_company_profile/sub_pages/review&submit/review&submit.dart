import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import '../../cubit/create_company_profile_cubit.dart';
import 'widgets/info_row.dart';

class ReviewSubmitPage extends StatelessWidget {
  const ReviewSubmitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 112,
              width: 112,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(Icons.local_pharmacy, color: Colors.white, size: 40),
            ),
            const Gap(AppSizesManager.s24),

            // Company Info
            const Text("Litidea Productions", style: AppTypography.headLine2Style),

            const Gap(AppSizesManager.s4),
            Text("Pharmacy", style: AppTypography.body1MediumStyle.copyWith(color: TextColors.ternary.color)),
            const Gap(AppSizesManager.s12),

            Text(
              "${BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.description}.",
              textAlign: TextAlign.center,
              style: AppTypography.body2RegularStyle.copyWith(color: TextColors.ternary.color),
            ),
            const Gap(AppSizesManager.s24),

            // General information
            const InfoRow(icon: Icons.email, label: "Email", dataValue: "Support@yassir.com"),
            const InfoRow(icon: Icons.phone, label: "Phone", dataValue: "+213 776 43 08 84"),
            InfoRow(
                icon: Icons.language,
                label: "Website",
                dataValue: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.website.isEmpty
                    ? "/"
                    : BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.website),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizesManager.p16),
              child: Divider(
                color: StrokeColors.normal.color,
              ),
            ),

            // Legal information
            InfoRow(label: "NIF", dataValue: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.nif),
            InfoRow(label: "NIS", dataValue: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.nis),
            InfoRow(
                label: "RC",
                dataValue: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.commercialRegNumber),
            InfoRow(label: "AI", dataValue: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.ai),
            InfoRow(
                label: "Credit Limit",
                dataValue: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.creditLimit),
          ],
        ),
      ),
    );
  }
}
