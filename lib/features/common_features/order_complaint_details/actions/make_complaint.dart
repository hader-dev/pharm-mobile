import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';

void makeComplaint(OrderComplaintsCubit cubit, GlobalKey<FormState> formKey,
    AppLocalizations localization) {
  if (!formKey.currentState!.validate()) return;
  cubit.makeComplaint(localization);
}
