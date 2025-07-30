


import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';

String? emptyValidator(String? value, AppLocalizations translation) {
  return null;
}


String? isRequired(String? value, AppLocalizations translation) {
  final trimmed = value?.trim() ?? '';
  if (trimmed.isEmpty) {
    return translation.feedback_field_required;
  }
  return null;
}


String? validateIsEmail(String? value, AppLocalizations translation, [bool required = false]) {
  final trimmed = value?.trim() ?? '';

  if (!required && trimmed.isEmpty) {
    return null;
  }

  if (required && trimmed.isEmpty) {
    return translation.feedback_field_required;
  }

  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regex.hasMatch(trimmed)) {
    return translation.feedback_email_not_valid;
  }

  return null;
}

String? validateIsWilayaNumber(String? value, AppLocalizations translation, [bool required = false]) {
  final trimmed = value?.trim() ?? '';

  if (!required && trimmed.isEmpty) {
    return null;
  }

  if (required && trimmed.isEmpty) {
    return translation.feedback_field_required;
  }

  if (!RegExp(r'^\d{2}$').hasMatch(trimmed)) {
    return translation.feedback_invalid_number;
  }

  final number = int.tryParse(trimmed);
  if (number == null || number < 1 || number > 58) {
    return translation.feedback_invalid_number;
  }

  return null;
}


String? validateIsCommuneNumber(String? value, AppLocalizations translation, [bool required = false]) {
  final trimmed = value?.trim() ?? '';

  if (!required && trimmed.isEmpty) {
    return null;
  }

  if (required && trimmed.isEmpty) {
    return translation.feedback_field_required;
  }

  if (!RegExp(r'^\d{5}$').hasMatch(trimmed)) {
    return translation.feedback_invalid_number;
  }

  final prefix = int.tryParse(trimmed.substring(0, 2));
  if (prefix == null || prefix < 1 || prefix > 58) {
    return translation.feedback_invalid_number;
  }

  return null;
}


String? validateIsNumber(String? value, AppLocalizations translation, [bool required = false]) {
  final trimmed = value?.trim() ?? '';

  if (!required && trimmed.isEmpty) {
    return null;
  }

  if (required && trimmed.isEmpty) {
    return translation.feedback_field_required;
  }

  final number = num.tryParse(trimmed);
  if (number == null) {
    return translation.feedback_invalid_number;
  }

  return null;
}

String? validateIsMobileNumber(String? value, AppLocalizations appLocalizations, [bool required = false]) {
  final trimmed = value?.trim() ?? '';

  if (!required && trimmed.isEmpty) {
    return null;
  }

  if (required && trimmed.isEmpty) {
    return appLocalizations.feedback_field_required;
  }

  final regex = RegExp(r'^(05|06|07)\d{8}$');
  if (!regex.hasMatch(trimmed)) {
    return appLocalizations.feedback_invalid_mobile_number;
  }

  return null;
}


String? validateIsFaxNumber(String? value, AppLocalizations appLocalizations, [bool required = false]) {
  final trimmed = value?.trim() ?? '';

  if (!required && trimmed.isEmpty) {
    return null;
  }

  if (required && trimmed.isEmpty) {
    return appLocalizations.feedback_field_required;
  }

  final regex = RegExp(r'^035\d{8}$');
  if (!regex.hasMatch(trimmed)) {
    return appLocalizations.feedback_invalid_fax_number;
  }

  return null;
}
