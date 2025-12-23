import 'package:hader_pharm_mobile/models/para_pharma.dart';

abstract class IParaPharmBrandRepository {
  Future<List<Brand>> getParaPharmBrands({String? searchValue});
}
