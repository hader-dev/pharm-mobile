import 'package:flutter/material.dart';

import '../config/theme/colors_manager.dart';
import 'assets_strings.dart';

// enum OrderStatus {
//   newStat(
//     id: 1,
//     color: Color.fromARGB(255, 73, 73, 73),
//     icon: Icons.new_releases,
//   ),
//   confirmed(
//     id: 2,
//     color: Colors.orange,
//     icon: Icons.play_arrow,
//   ),
//   completed(
//     id: 3,
//     color: Colors.green,
//     icon: Icons.check_circle,
//   ),
//   canceled(
//     id: 4,
//     color: Colors.red,
//     icon: Icons.cancel,
//   );

//   final int id;

//   final Color color;
//   final IconData icon;

//   const OrderStatus({
//     required this.id,
//     required this.color,
//     required this.icon,
//   });

//   static String translateLabel(BuildContext context, OrderStatus expression) {
//     return '';
//     // switch (expression) {
//     //   case OrderStatus.newStat:
//     //     return context.translation!.wait_for_approval;

//     //   case OrderStatus.confirmed:
//     //     return context.translation!.confirmed;

//     //   case OrderStatus.completed:
//     //     return context.translation!.completed;

//     //   case OrderStatus.canceled:
//     //     return context.translation!.canceled;

//     //   default:
//     //     return context.translation!.unknown;
//     // }
//   }

//   static String translateDescription(BuildContext context, OrderStatus expression) {
//     return '';
//     // switch (expression) {
//     //   case OrderStatus.newStat:
//     //     return context.translation!.wait_for_approval_desc;

//     //   case OrderStatus.confirmed:
//     //     return context.translation!.confirmed_desc;

//     //   case OrderStatus.completed:
//     //     return context.translation!.completed;

//     //   case OrderStatus.canceled:
//     //     return context.translation!.canceled_desc;

//     //   default:
//     //     return context.translation!.unknown;
//     // }
//   }
// }

enum CompanyType {
  distributor(id: 1, imgPath: DrawableAssetStrings.companyIllustration2),
  pharmacy(id: 2, imgPath: DrawableAssetStrings.companyIllustration1);

  final int id;
  final String imgPath;

  const CompanyType({
    required this.id,
    required this.imgPath,
  });
}

enum DistributorCategory {
  pharmacy(
    id: 1,
  ),
  paraPharmacy(
    id: 2,
  ),
  both(
    id: 3,
  );

  final int id;

  const DistributorCategory({
    required this.id,
  });
}

enum DialogType {
  info(
    color: Colors.blue,
    icon: Icons.info_outline,
  ),
  success(
    color: Colors.green,
    icon: Icons.check_circle_outline,
  ),
  warning(
    color: Colors.orange,
    icon: Icons.warning_amber_outlined,
  ),
  error(
    color: Colors.red,
    icon: Icons.close,
  );

  final Color color;
  final IconData icon;

  const DialogType({
    required this.color,
    required this.icon,
  });
}

enum Role {
  superAdmin(1),
  admin(2),
  company(3),
  client(4);

  final int id;

  const Role(this.id);
}

enum FieldState {
  normal(color: SystemColors.defaultState),
  loading(wordKey: "Loading", color: SystemColors.defaultState),
  disabled(color: SystemColors.defaultState),
  success(wordKey: "Success", color: SystemColors.green, icon: Icons.check_circle),
  warning(wordKey: "Warning", color: SystemColors.orange, icon: Icons.warning_amber_rounded),
  error(wordKey: "Error", color: SystemColors.red, icon: Icons.error);

  final SystemColors color;
  final IconData? icon;
  final String wordKey;
  const FieldState({this.wordKey = '', required this.color, this.icon});
}

enum ApiErrorCodes {
  UNKNOWN('UNKNOWN', 'UNKNOWN'),
  // Auth
  NO_TOKEN('NO_TOKEN', 'No token provided'),
  TOKEN_EXPIRED('TOKEN_EXPIRED', 'Token has expired'),

  TOKEN_REUSED('TOKEN_REUSED', 'Token has been reused'),
  REFRESH_TOKEN_REUSED('REFRESH_TOKEN_REUSED', 'Refresh token has been reused'),
  REFRESH_TOKEN_EXPIRED('REFRESH_TOKEN_EXPIRED', 'Refresh token has expired'),
  INVALID_TOKEN('INVALID_TOKEN', 'Invalid token'),
  INVALID_REFRESH_TOKEN('INVALID_REFRESH_TOKEN', 'Invalid refresh token'),
  INVALID_CREDENTIALS('INVALID_CREDENTIALS', 'Email or password is incorrect'),
  INVALID_PASSWORD('INVALID_PASSWORD', 'Invalid password'),
  INVALID_OTP('INVALID_OTP', 'Invalid OTP'),
  INVALID_PASSWORD_RESET_TOKEN('INVALID_PASSWORD_RESET_TOKEN', 'Invalid password reset token'),
  EMAIL_NOT_VERIFIED('EMAIL_NOT_VERIFIED', 'Email not verified'),
  INCORRECT_PASSWORD('INCORRECT_PASSWORD', 'Incorrect password');

  final String label;
  final String errorMessage;
  const ApiErrorCodes(this.label, this.errorMessage);
}
