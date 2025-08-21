import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

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
            style: context.responsiveTextTheme.current.headLine3SemiBold,
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
