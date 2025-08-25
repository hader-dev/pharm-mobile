// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../config/theme/colors_manager.dart';
import 'assets_strings.dart';

enum OrderClaimStatus {
  pending(
    id: 1,
    color: Color.fromARGB(255, 106, 106, 106),
    icon: Icons.new_releases,
  ),
  processing(
    id: 2,
    color: Colors.orange,
    icon: Icons.play_arrow,
  ),
  rejected(
    id: 3,
    color: Colors.green,
    icon: Icons.check_circle,
  ),
  resolved(
    id: 4,
    color: Colors.red,
    icon: Icons.cancel,
  );

  final int id;

  final Color color;
  final IconData icon;

  const OrderClaimStatus({
    required this.id,
    required this.color,
    required this.icon,
  });

  static String getTranslatedStatus(OrderClaimStatus expression) {
    switch (expression) {
      case OrderClaimStatus.pending:
        return RoutingManager
            .rootNavigatorKey.currentContext!.translation!.pending;

      case OrderClaimStatus.processing:
        return RoutingManager
            .rootNavigatorKey.currentContext!.translation!.processing;

      case OrderClaimStatus.rejected:
        return RoutingManager
            .rootNavigatorKey.currentContext!.translation!.rejected;

      case OrderClaimStatus.resolved:
        return RoutingManager
            .rootNavigatorKey.currentContext!.translation!.resolved;
    }
  }
}

enum OrderStatus {
  pending(
    id: 1,
    color: Color.fromARGB(255, 106, 106, 106),
    icon: Icons.new_releases,
  ),
  confirmed(
    id: 2,
    color: Colors.orange,
    icon: Icons.play_arrow,
  ),
  completed(
    id: 3,
    color: Colors.green,
    icon: Icons.check_circle,
  ),
  canceled(
    id: 4,
    color: Colors.red,
    icon: Icons.cancel,
  );

  final int id;

  final Color color;
  final IconData icon;

  const OrderStatus({
    required this.id,
    required this.color,
    required this.icon,
  });

  static String getTranslatedStatus(OrderStatus expression) {
    switch (expression) {
      case OrderStatus.pending:
        return RoutingManager
            .rootNavigatorKey.currentContext!.translation!.pending;

      case OrderStatus.confirmed:
        return RoutingManager
            .rootNavigatorKey.currentContext!.translation!.confirmed;

      case OrderStatus.completed:
        return RoutingManager
            .rootNavigatorKey.currentContext!.translation!.completed;

      case OrderStatus.canceled:
        return RoutingManager
            .rootNavigatorKey.currentContext!.translation!.canceled;
    }
  }

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
}

enum SearchMedicineFilters { dci, sku, code }

enum SearchParaPharmaFilters { name, packaging, sku, description }

enum SearchVendorFilters { name, address, phone, email, description }

enum ProductTypes { medicine, para_pharmacy }

enum PaymentMethods {
  cash(id: 1, label: "cash"),
  bank_transfer(id: 2, label: "bank_transfer");

  final String label;
  final int id;
  const PaymentMethods({required this.id, required this.label});
}

extension PaymentMethodsExtension on PaymentMethods {
  String translation(AppLocalizations translation) {
    switch (this) {
      case PaymentMethods.cash:
        return translation.cash;
      case PaymentMethods.bank_transfer:
        return translation.bank_transfer;
    }
  }
}

enum InvoiceTypes {
  facture(id: 1),
  proforma(id: 2);

  final int id;
  const InvoiceTypes({required this.id});
}

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
  pharmacy(id: 1, color: Colors.green),
  paraPharmacy(id: 2, color: Colors.blue),
  both(id: 3, color: Color.fromARGB(255, 96, 79, 183));

  final int id;
  final Color color;

  const DistributorCategory({
    required this.id,
    required this.color,
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
  success(
      wordKey: "Success", color: SystemColors.green, icon: Icons.check_circle),
  warning(
      wordKey: "Warning",
      color: SystemColors.orange,
      icon: Icons.warning_amber_rounded),
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
  INVALID_PASSWORD_RESET_TOKEN(
      'INVALID_PASSWORD_RESET_TOKEN', 'Invalid password reset token'),
  EMAIL_NOT_VERIFIED('EMAIL_NOT_VERIFIED', 'Email not verified'),
  INCORRECT_PASSWORD('INCORRECT_PASSWORD', 'Incorrect password');

  final String label;
  final String errorMessage;
  const ApiErrorCodes(this.label, this.errorMessage);
}
