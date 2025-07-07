import 'package:hader_pharm_mobile/utils/enums.dart';

class CreateCartItemModel {
  final String productId;
  final int quantity;
  final ProductTypes productType;

  String note;
  CreateCartItemModel({required this.productId, required this.quantity, required this.productType, this.note = ''});
  Map<String, dynamic> toMap() => {
        if (productType == ProductTypes.medicine) ...{
          'medicineCatalogId': productId
        } else ...{
          'parapharmCatalogId': productId
        },
        'quantity': quantity,
      };
}
