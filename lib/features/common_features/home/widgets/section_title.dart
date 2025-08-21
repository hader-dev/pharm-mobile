import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizesManager.p6),
      child: Text(
        title,
        style: context.responsiveTextTheme.current.headLine5SemiBold,
      ),
    );
  }
}
