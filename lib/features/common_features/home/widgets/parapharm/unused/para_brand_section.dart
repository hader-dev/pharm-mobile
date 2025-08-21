import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/parapharm/unused/para_brand.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class BrandsSection extends StatelessWidget {
  const BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Container(
      color: Colors.white.withAlpha(100),
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: AppSizesManager.p8, bottom: AppSizesManager.p8),
            child: Text(translation.brands,
                style: context.responsiveTextTheme.current.body2Medium),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 100),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  10,
                  (index) => BrandCircularWidget(
                        categoryName: index.toString(),
                        imageUrl:
                            "https://logos-world.net/wp-content/uploads/2020/09/Dove-Logo-1969-2004.png",
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
