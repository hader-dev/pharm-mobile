import 'package:hader_pharm_mobile/repositories/remote/clients/responses/response_create_client.dart';

ResponseCreateClient jsonToResponseCreateClient(Map<String, dynamic> json) {
  return ResponseCreateClient(
    id: json["id"] ?? "",
    password: json["password"] ?? '',
    email: json["email"] ?? '',
    
  );
}
