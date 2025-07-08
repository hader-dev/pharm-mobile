class CreateQuickOrderModel {
  String? clientNote;
  String deliveryAddress;
  int deliveryTownId;
  String? paraPharmaCatalogId;
  String? medicineCatalogId;
  int qty;

  double? latitude;
  double? longitude;

  CreateQuickOrderModel(
      {required this.deliveryAddress,
      required this.deliveryTownId,
      this.qty = 0,
      this.clientNote,
      this.paraPharmaCatalogId,
      this.medicineCatalogId,
      this.latitude,
      this.longitude});
  Map<String, dynamic> toJson() {
    return {
      if (paraPharmaCatalogId != null) 'parapharmCatalogId': paraPharmaCatalogId,
      if (medicineCatalogId != null) 'medicineCatalogId': medicineCatalogId,
      if (clientNote != null && clientNote!.isNotEmpty) 'clientNote': clientNote,
      'deliveryAddress': deliveryAddress,
      'deliveryTownId': deliveryTownId,
      'quantity': qty,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude
    };
  }
}
