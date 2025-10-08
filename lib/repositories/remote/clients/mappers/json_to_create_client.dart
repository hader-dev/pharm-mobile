import 'package:hader_pharm_mobile/repositories/remote/clients/responses/response_create_client.dart';

ResponseCreateClient jsonToResponseCreateClient(Map<String, dynamic> json) {
  return ResponseCreateClient(
    id: json["safeUser"]["id"] ?? "",
    password: json["password"] ?? '',
    email: json["safeUser"]["email"] ?? '',
  );
}
