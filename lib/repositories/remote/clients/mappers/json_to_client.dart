import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/responses/response_my_clients.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';

DelegateClient jsonToClient(Map<String, dynamic> json) {
  return DelegateClient(
    id: json['id'] ?? '',
    createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now()),
    updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now()),
    sellerCompanyId: json['sellerCompanyId'] ?? '',
    buyerCompanyId: json['buyerCompanyId'] ?? '',
    createdByUserId: json['createdByUserId'] ?? '',
    approvedAt: json['approvedAt'] != null ? DateTime.parse(json['approvedAt']) : null,
    rejectedAt: json['rejectedAt'] != null ? DateTime.parse(json['rejectedAt']) : null,
    joinMethod: json['joinMethod'],
    status: json['status'],
    buyerCompany: json['buyerCompany'] != null ? jsonToCompany(json['buyerCompany']) : Company.empty(),
  );
}

ResponseMyClients jsonToResponseMyClients(Map<String, dynamic> json) {
  var clientsJson = json['data'] as List<dynamic>? ?? [];

  List<DelegateClient> clients = clientsJson.map((clientJson) => jsonToClient(clientJson)).toList();

  return ResponseMyClients(
    clients: clients,
    totalItems: json['totalItems'] ?? 0,
  );
}
