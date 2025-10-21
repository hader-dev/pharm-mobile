import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class SilverTags extends StatelessWidget {
  const SilverTags(
      {super.key,
      required this.tags,
      this.backgroundColor = AppColors.accent1Shade1});
  final List<String> tags;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizesManager.s4,
      children: tags
          .map((tag) => Badge(
                padding: const EdgeInsets.all(AppSizesManager.p4),
                backgroundColor: backgroundColor,
                label: Text(tag),
              ))
          .toList(),
    );
  }
}
