import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/dialog/validation_dialog.dart';

import '../../../config/services/auth/user_manager.dart';
import '../../../utils/enums.dart';

class AppDialogs {
  static Future<void> showLogoutDialogLogout() async {
    await getItInstance.get<ValidateActionDialog>().showValidateActionDialog(
        agreeText: "logout",
        cancelText: "Cancel",
        dialogType: DialogType.warning,
        title: Text("Logout Confirmation", style: AppTypography.headLine3SemiBoldStyle),
        content: Text("Are you sure you want to logout?", style: AppTypography.body3MediumStyle),
        onValidate: () async {
          getItInstance.get<UserManager>().logout();
        });
  }
}
