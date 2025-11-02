import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/di/di.dart';
import '../../../../config/services/auth/user_manager.dart';
import '../../../../config/theme/colors_manager.dart';
import 'image_user.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = getItInstance.get<UserManager>().currentUser;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.responsiveAppSizeTheme.current.p8,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent1Shade3,
        borderRadius: BorderRadius.circular(
            context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      child: Row(
        children: <Widget>[
          UserImage(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.responsiveAppSizeTheme.current.p6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  currentUser.fullName,
                  style: context.responsiveTextTheme.current.headLine4SemiBold,
                ),
                Text(
                  currentUser.email,
                  style: context.responsiveTextTheme.current.body2Regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
