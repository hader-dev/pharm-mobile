import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class BottomSheetHeader extends StatelessWidget {
  final String title;

  const BottomSheetHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizesManager.p12,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: AppTypography.headLine3SemiBoldStyle,
          ),
          Spacer(),
          InkWell(
            onTap: () => context.pop(),
            child: Icon(
              Icons.close,
              size: AppSizesManager.iconSize20,
            ),
          )
        ],
      ),
    );
  }
}
