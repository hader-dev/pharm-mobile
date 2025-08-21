import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'para_cartegory.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSizesManager.p8,
          ),
          child: Text('Categories',
              style: context.responsiveTextTheme.current.headLine5SemiBold),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 100),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                10,
                (index) => CategoryCircularWidget(
                      categoryName: index.toString(),
                      imageUrl:
                          "https://logos-world.net/wp-content/uploads/2020/09/Dove-Logo-1969-2004.png",
                    )),
          ),
        ),
      ],
    );
  }
}
