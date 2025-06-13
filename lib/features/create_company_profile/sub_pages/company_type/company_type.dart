import 'package:flutter/material.dart';

import '../../../../utils/assets_strings.dart';
import '../../../../utils/constants.dart';
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
          children: [
            TypeCard(
              title: "Pharmacy",
              index: 0,
              selectedTypeIndex: 0,
              imagePath: DrawableAssetStrings.companyIllustration1,
            ),
            TypeCard(
              title: "Distributor",
              index: 1,
              selectedTypeIndex: 0,
              imagePath: DrawableAssetStrings.companyIllustration2,
            ),
            TypeCard(
              title: "Parapharm - Seller",
              index: 2,
              selectedTypeIndex: 0,
              imagePath: DrawableAssetStrings.companyIllustration3,
            )
          ],
        ),
      ),
    );
  }
}
