import 'shipping_address.dart';

class ClientModel {
  final int clientId;
  final String code;
  final String ref;
  final String? firstName;
  final String? lastName;
  final String tradeName;
  final String address;
  final DateTime birthDate;
  final String? note;
  final String? phone;
  final String? mobile;
  final String? fax;
  final String email;
  final String? webPage;
  final String? rc;
  final String? agr;
  final String? ai;
  final String? activity;
  final String legalForm;
  final String idFiscal;
  final String? imgPath;
  final List<ShippingAddress> addresses;

  ClientModel({
    required this.clientId,
    required this.code,
    required this.ref,
    this.firstName,
    this.lastName,
    required this.tradeName,
    required this.address,
    required this.birthDate,
    this.note,
    this.phone,
    this.mobile,
    this.fax,
    required this.email,
    this.webPage,
    this.rc,
    this.agr,
    this.ai,
    this.activity,
    required this.legalForm,
    required this.idFiscal,
    this.imgPath,
    this.addresses = const <ShippingAddress>[],
  });
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      clientId: json['id'],
      code: json['code'],
      ref: json['ref'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      tradeName: json['tradeName'],
      address: json['address'],
      birthDate: DateTime.parse(json['birthDate']),
      note: json['note'],
      phone: json['phone'],
      mobile: json['mobile'],
      fax: json['fax'],
      email: json['email'],
      webPage: json['webPage'],
      rc: json['rc'],
      agr: json['agr'],
      ai: json['ai'],
      activity: json['activity'],
      legalForm: json['legalForm'],
      idFiscal: json['idFiscal'],
      imgPath: json['imgPath'],
      addresses: json['shippingAddresses'] == null
          ? <ShippingAddress>[]
          : (json['shippingAddresses'] as List).map((address) => ShippingAddress.fromJson(address)).toList(),
    );
  }
}
