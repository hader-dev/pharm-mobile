import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/responses/response_load_filters_medical.dart';

ResponseLoadFiltersMedical jsonToLoadFiltersMedicalResponse(
    Map<String, dynamic> json) {
  final data = json as Map<String, dynamic>? ?? {};

  List<String> listFrom(dynamic value) {
    if (value is List) {
      return value.whereType<String>().toList();
    }
    return [];
  }

  return ResponseLoadFiltersMedical(
      filters: MedicalFilters(
    dci: listFrom(data['dci']),
    dosage: listFrom(data['dosage']),
    form: listFrom(data['form']),
    status: listFrom(data['status']),
    registrationDate: listFrom(data['registrationDate']),
    country: listFrom(data['country']),
    patent: listFrom(data['patent']),
    brand: listFrom(data['brand']),
    condition: listFrom(data['condition']),
    type: listFrom(data['type']),
    stabilityDuration: listFrom(data['stabilityDuration']),
    sku: listFrom(data['sku']),
    packagingFormat: listFrom(data['packagingFormat']),
    code: listFrom(data['code']),
    reimbursement: listFrom(data['reimbursement']),
  ));
}
