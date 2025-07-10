import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/widget/brand.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../../../config/theme/typoghrapy_manager.dart';
import 'cartegory.dart';

class BrandsSection extends StatelessWidget {
  const BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSizesManager.p8,
          ),
          child: Text('Brands', style: AppTypography.headLine4SemiBoldStyle),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 100),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                10,
                (index) => BrandCircularWidget(
                      categoryName: index.toString(),
                      imageUrl: "https://logos-world.net/wp-content/uploads/2020/09/Dove-Logo-1969-2004.png",
                    )),
          ),
        ),
      ],
    );
  }
}
