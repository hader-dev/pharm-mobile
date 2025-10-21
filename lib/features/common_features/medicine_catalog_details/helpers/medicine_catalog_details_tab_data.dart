import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

List<String> medicineCatalogDetailsTabData(BuildContext context) {
  final translation = context.translation!;
  return [translation.medicine_overview, translation.about_distributor];
}
