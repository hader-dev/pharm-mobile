import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CategoryCircularWidget extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  final VoidCallback? onTap;

  const CategoryCircularWidget({
    super.key,
    required this.imageUrl,
    required this.categoryName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizesManager.p6),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 42,
              height: 42,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          const Gap(AppSizesManager.s6),
          Text(
            categoryName,
            style: context.responsiveTextTheme.current.body3Medium,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
