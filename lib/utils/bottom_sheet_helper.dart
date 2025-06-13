import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';


class BottomSheetHelper {
  static Future<void> showCommonBottomSheet({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    double? maxHeight,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          maxChildSize: maxHeight ?? 0.9,
          minChildSize: 0.3,
          builder: (_, controller) => Container(
            padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  Container(
                    height: 4,
                    width: 36,
                    margin: const EdgeInsets.symmetric(vertical: AppSizesManager.p12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 165, 169, 181),
                      borderRadius: BorderRadius.circular(AppSizesManager.r6),
                    ),
                  ),
                  child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
