import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import '../../../utils/constants.dart';
import '../../../utils/enums.dart';

class ValidateActionDialog {
  bool result = false;
  Future<void> showValidateActionDialog({
    Function? onValidate,
    Function? onCancel,
    Widget? title,
    Widget? content,
    bool canceledEnabled = true,
    bool okEnabled = true,
    bool isDismissible = true,
    DialogType dialogType = DialogType.info,
    String agreeText = "Ok",
    String cancelText = "Cancel",
  }) async {
    await showDialog<void>(
      context: RoutingManager.rootNavigatorKey.currentContext!,
      barrierDismissible: isDismissible,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              elevation: 0,
              insetAnimationCurve: Curves.ease,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSizesManager.p16),
                      child: CircleAvatar(
                        backgroundColor: dialogType.color.withOpacity(.2),
                        minRadius: AppSizesManager.r30,
                        child: Icon(
                          dialogType.icon,
                          color: dialogType.color,
                          size: AppSizesManager.iconSize25,
                        ),
                      ),
                    ),
                    if (title != null) Align(alignment: Alignment.center, child: title),
                    const SizedBox(height: AppSizesManager.s12),
                    if (content != null) Align(alignment: Alignment.center, child: content),
                    Padding(
                      padding: const EdgeInsets.all(AppSizesManager.p16),
                      child: Row(
                        children: [
                          const Spacer(),
                          if (canceledEnabled)
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                cancelText,
                                style: AppTypography.body3MediumStyle
                                    .copyWith(color: AppColors.accentGreenShade2.withAlpha(200)),
                              ),
                            ),
                          if (okEnabled)
                            TextButton(
                              onPressed: () {
                                result = true;
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                agreeText,
                                style: AppTypography.body3MediumStyle.copyWith(color: AppColors.accentGreenShade2),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      if (result) {
        onValidate!();
      } else {
        onCancel!();
      }
    });
  }
}
