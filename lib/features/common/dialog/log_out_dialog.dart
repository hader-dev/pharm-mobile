import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/dialog/validation_dialog.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../config/services/auth/user_manager.dart';
import '../../../utils/enums.dart';

class AppDialogs {
  static Future<void> showLogoutDialogLogout() async {
    await getItInstance.get<ValidateActionDialog>().showValidateActionDialog(
        agreeText: RoutingManager.rootNavigatorKey.currentContext!.translation!.logout,
        cancelText: RoutingManager.rootNavigatorKey.currentContext!.translation!.cancel,
        dialogType: DialogType.warning,
        title: Text(RoutingManager.rootNavigatorKey.currentContext!.translation!.logout_confirmation,
            style: AppTypography.headLine3SemiBoldStyle),
        content: Text(RoutingManager.rootNavigatorKey.currentContext!.translation!.logout_confirmation_message,
            style: AppTypography.body3MediumStyle),
        onCancel: () {},
        onValidate: () async {
          getItInstance.get<UserManager>().logout();
        });
  }
}
