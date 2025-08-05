import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/responses/response_load_filters_para_medical.dart';

ResponseLoadFiltersParaMedical jsonToLoadFiltersParaMedicalResponse(
    Map<String, dynamic> json) {
  final data = json as Map<String, dynamic>? ?? {};

  List<String> listFrom(dynamic value) {
    if (value is List) {
      return value.whereType<String>().toList();
    }
    return [];
  }

  return ResponseLoadFiltersParaMedical(
      filters: ParaMedicalFilters(
    
    dosage: listFrom(data['dosage']),
    status: listFrom(data['status']),
    country: listFrom(data['country']),
    patent: listFrom(data['patent']),
    brand: listFrom(data['brand']),
    condition: listFrom(data['condition']),
    type: listFrom(data['type']),
    stabilityDuration: listFrom(data['stabilityDuration']),
    distributorSku: listFrom(data['distributorSku']),
    code: listFrom(data['code']),
    reimbursement: listFrom(data['reimbursement']),
  ));
}
