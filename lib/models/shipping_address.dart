import 'package:equatable/equatable.dart';

class ShippingAddress extends Equatable {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic syncId;
  double? latitude;
  double? longitude;
  String address;
  final int clientId;
  int townId;
  @override
  List<Object?> get props => [id];

  ShippingAddress({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.syncId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.clientId,
    required this.townId,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      syncId: json['syncId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      clientId: json['clientId'],
      townId: json['townId'],
    );
  }
}
