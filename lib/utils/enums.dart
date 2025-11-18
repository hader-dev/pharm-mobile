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
    id: 5,
    color: Colors.red,
    icon: Icons.cancel,
  ),
  resolved(
    id: 4,
    color: Colors.green,
    icon: Icons.check_circle,
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
        return RoutingManager.rootNavigatorKey.currentContext!.translation!.pending;

      case OrderClaimStatus.processing:
        return RoutingManager.rootNavigatorKey.currentContext!.translation!.processing;

      case OrderClaimStatus.rejected:
        return RoutingManager.rootNavigatorKey.currentContext!.translation!.rejected;

      case OrderClaimStatus.resolved:
        return RoutingManager.rootNavigatorKey.currentContext!.translation!.resolved;
    }
  }
}

enum OrderStatus {
  created(
    id: 1,
    color: Colors.lightBlueAccent, // gray
    icon: Icons.new_releases, // "new"
  ),
  approved(
    id: 2,
    color: Colors.green,
    icon: Icons.check_circle,
  ),
  rejected(
    id: 3,
    color: Colors.red,
    icon: Icons.cancel,
  ),
  cancelled(
    id: 4,
    color: Colors.redAccent,
    icon: Icons.remove_circle,
  ),
  processing(
    id: 5,
    color: Colors.orange,
    icon: Icons.autorenew,
  ),
  ready(
    id: 6,
    color: Colors.blueAccent,
    icon: Icons.shopping_bag,
  ),
  delivered(
    id: 7,
    color: Colors.teal,
    icon: Icons.local_shipping,
  ),
  returned(
    id: 8,
    color: Colors.purple,
    icon: Icons.reply,
  ),
  failed(
    id: 9,
    color: Colors.deepOrange,
    icon: Icons.error,
  );

  final int id;

  final Color color;
  final IconData icon;

  const OrderStatus({
    required this.id,
    required this.color,
    required this.icon,
  });

  static String getTranslatedStatusFromString(String rawValue) {
    final parsedValue = rawValue.toLowerCase();
    final status =
        OrderStatus.values.firstWhere((element) => element.name == parsedValue, orElse: () => OrderStatus.created);

    return getTranslatedStatus(status);
  }

  static String getTranslatedStatus(OrderStatus status) {
    final context = RoutingManager.rootNavigatorKey.currentContext!;
    final t = context.translation!;

    switch (status) {
      case OrderStatus.created:
        return t.created;

      case OrderStatus.approved:
        return t.approved;

      case OrderStatus.rejected:
        return t.rejected;

      case OrderStatus.cancelled:
        return t.cancelled;

      case OrderStatus.processing:
        return t.processing;

      case OrderStatus.ready:
        return t.ready;

      case OrderStatus.delivered:
        return t.delivered;

      case OrderStatus.returned:
        return t.returned;

      case OrderStatus.failed:
        return t.failed;
    }
  }
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

  String translation(AppLocalizations translation) {
    switch (this) {
      case InvoiceTypes.facture:
        return translation.invoice;
      case InvoiceTypes.proforma:
        return translation.proforma;
    }
  }
}

enum CompanyType {
  Distributor(id: 1, imgPath: DrawableAssetStrings.companyIllustration2),
  Pharmacy(id: 2, imgPath: DrawableAssetStrings.companyIllustration1),
  Other(id: 4, imgPath: DrawableAssetStrings.companyIllustration3);

  final int id;
  final String imgPath;

  const CompanyType({
    required this.id,
    required this.imgPath,
  });
}

extension CompanyTypeDisplayNameExtension on CompanyType {
  String displayName(AppLocalizations translation) {
    switch (this) {
      case CompanyType.Distributor:
        return translation.distrubutor;
      case CompanyType.Pharmacy:
        return translation.pharmacy;
      case CompanyType.Other:
        return translation.other_activity;
    }
  }
}

enum DistributorCategory {
  Pharmacy(id: 1, color: Colors.green),
  ParaPharmacy(id: 2, color: Colors.blue),
  Both(id: 3, color: Color.fromARGB(255, 96, 79, 183));

  final int id;
  final Color color;

  const DistributorCategory({
    required this.id,
    required this.color,
  });
}

extension DistributorCategoryDisplayNameExtension on DistributorCategory {
  String displayName(AppLocalizations translation) {
    switch (this) {
      case DistributorCategory.Pharmacy:
        return translation.pharma;
      case DistributorCategory.ParaPharmacy:
        return translation.para_pharma;
      case DistributorCategory.Both:
        return translation.other_activity;
    }
  }
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
  UNAUTHORIZED_DISTRIBUTOR_LOGIN('UNAUTHORIZED_DISTRIBUTOR_LOGIN', 'Unauthorized distributor login'),
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
