import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/medicine_catalog_details.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/button_sections/buttons_section_v2.dart';

class MedicineCatalogDetailsClientScreen extends StatelessWidget {
  final String medicineCatalogId;
  final bool canOrder;
  final bool disabledPackageQuanity;
  static final GlobalKey<ScaffoldState> medicineDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();
  final String? buyerCompanyId;

  const MedicineCatalogDetailsClientScreen(
      {super.key,
      required this.medicineCatalogId,
      required this.canOrder,
      this.buyerCompanyId,
      this.disabledPackageQuanity = false});

  @override
  Widget build(BuildContext context) {
    return BaseMedicineCatalogDetailsScreen(
      medicineCatalogId: medicineCatalogId,
      buyerCompanyId: buyerCompanyId,
      canOrder: canOrder,
      needCartCubit: true,
      quantitySectionBuilder: (double price) => ButtonsSectionV2(
        quantitySectionAlignment: MainAxisAlignment.center,
        disabledPackageQuanity: disabledPackageQuanity,
        price: price,
      ),
    );
  }
}
