import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../config/di/di.dart';
import '../../../../config/services/auth/user_manager.dart';
import 'image_user.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const UserImage(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getItInstance.get<UserManager>().currentUser.fullName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                getItInstance.get<UserManager>().currentUser.email,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
