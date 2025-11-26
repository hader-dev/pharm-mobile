import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart' show ResponsiveGap;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class GoogleAuthLoadingDialog extends StatelessWidget {
  const GoogleAuthLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return Container(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ResponsiveGap.s16(),
          Text(
            translation.loading_text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ResponsiveGap.s8(),
          Text(
            " ${translation.getting_info_google} ",
            textAlign: TextAlign.center,
          ),
          ResponsiveGap.s24(),
        ],
      ),
    );
  }
}
