import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
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
              "El Amine Pharma is a certified Algerian pharmaceutical producer specializing in generic medicines and over-the-counter drugs. "
              "Established in 2012, we supply hospitals and pharmacies across 28 wilayas.",
              textAlign: TextAlign.center,
              style: AppTypography.body2RegularStyle.copyWith(color: TextColors.ternary.color),
            ),
            const Gap(AppSizesManager.s24),

            // General information
            const InfoRow(icon: Icons.email, label: "Email", dataValue: "Support@yassir.com"),
            const InfoRow(icon: Icons.phone, label: "Phone", dataValue: "+213 776 43 08 84"),
            const InfoRow(icon: Icons.language, label: "Website", dataValue: "www.yassir.com"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizesManager.p16),
              child: Divider(
                color: StrokeColors.normal.color,
              ),
            ),

            // Legal information
            const InfoRow(label: "NIF", dataValue: "4564897451231"),
            const InfoRow(label: "NIS", dataValue: "584545"),
            const InfoRow(label: "RC", dataValue: "454967/87"),
            const InfoRow(label: "AI", dataValue: "1246476"),
            const InfoRow(label: "Credit Limit", dataValue: "15000000"),
          ],
        ),
      ),
    );
  }
}
