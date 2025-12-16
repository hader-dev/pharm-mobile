import 'package:hader_pharm_mobile/models/client.dart';

class ResponseMyClients {
  final List<DelegateClient> clients;
  final int totalItems;

  ResponseMyClients({required this.clients, required this.totalItems});
}
