import 'package:hader_pharm_mobile/models/company.dart';

class DeligateClient {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String sellerCompanyId;
  final String buyerCompanyId;
  final String createdByUserId;
  final DateTime? approvedAt;
  final DateTime? rejectedAt;
  final int joinMethod;
  final int status;
  final Company buyerCompany;

  DeligateClient({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.sellerCompanyId,
    required this.buyerCompanyId,
    required this.createdByUserId,
    this.approvedAt,
    this.rejectedAt,
    required this.joinMethod,
    required this.status,
    required this.buyerCompany,
  });
}
