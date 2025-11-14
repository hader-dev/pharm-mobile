import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: context.responsiveTextTheme.current.headLine4SemiBold.copyWith(
            color: Colors.black,
          ),
        ));
  }
}
