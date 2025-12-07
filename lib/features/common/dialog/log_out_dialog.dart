import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common/dialog/validation_dialog.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../utils/enums.dart';

class AppDialogs {
  static Future<void> showLogoutDialogLogout(
    BuildContext context,
    Function? onValidate,
    Function? onCancel,
  ) async {
    await getItInstance.get<ValidateActionDialog>().showValidateActionDialog(
        agreeText:
            RoutingManager.rootNavigatorKey.currentContext!.translation!.logout,
        cancelText:
            RoutingManager.rootNavigatorKey.currentContext!.translation!.cancel,
        dialogType: DialogType.warning,
        title: Text(
            RoutingManager.rootNavigatorKey.currentContext!.translation!
                .logout_confirmation,
            textAlign: TextAlign.center,
            style: context.responsiveTextTheme.current.headLine3SemiBold),
        content: Text(
            RoutingManager.rootNavigatorKey.currentContext!.translation!
                .logout_confirmation_message,
            textAlign: TextAlign.center,
            style: context.responsiveTextTheme.current.body3Medium),
        onCancel: onCancel,
        onValidate: onValidate);
  }
}
