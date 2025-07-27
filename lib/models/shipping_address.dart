import 'package:equatable/equatable.dart';

class ShippingAddress extends Equatable {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic syncId;
  final double? latitude;
  final double? longitude;
  final String address;
  final int clientId;
  final int townId;
  @override
  List<Object?> get props => [id];

  const ShippingAddress({
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
