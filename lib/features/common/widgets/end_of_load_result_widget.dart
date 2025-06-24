import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import 'package:flutter/material.dart';

class EndOfLoadResultWidget extends StatelessWidget {
  const EndOfLoadResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
          alignment: Alignment.center, child: Text("No more results to load.", style: AppTypography.bodySmallStyle)),
    );
  }
}
