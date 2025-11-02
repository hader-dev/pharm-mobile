import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class EndOfLoadResultWidget extends StatelessWidget {
  const EndOfLoadResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
          alignment: Alignment.center,
          child: Text("No more results to load.",
              style: context.responsiveTextTheme.current.bodySmall)),
    );
  }
}
