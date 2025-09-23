import 'package:hader_pharm_mobile/models/client.dart';

class ResponseMyClients {
  final List<DeligateClient> clients;
  final int totalItems;

  ResponseMyClients({required this.clients, required this.totalItems});
}
