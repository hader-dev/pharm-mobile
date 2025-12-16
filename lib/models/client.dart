import 'package:hader_pharm_mobile/models/company.dart';

class DelegateClient {
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

  const DelegateClient({
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

  factory DelegateClient.empty() {
    return DelegateClient(
      id: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      sellerCompanyId: '',
      buyerCompanyId: '',
      createdByUserId: '',
      joinMethod: 0,
      status: 0,
      buyerCompany: Company.empty(),
    );
  }
}
