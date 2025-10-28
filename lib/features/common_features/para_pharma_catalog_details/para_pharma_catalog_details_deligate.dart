import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/para_pharma_catalog_details.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/button_sections/buttons_section_deligate.dart';

class DeligateParaPharmaCatalogDetailsScreen extends StatelessWidget {
  final String paraPharmaCatalogId;
  final bool canOrder;
  final bool disabledPackageQuanity;
  static final GlobalKey<ScaffoldState> paraPharmaDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();

  const DeligateParaPharmaCatalogDetailsScreen(
      {super.key,
      required this.paraPharmaCatalogId,
      required this.canOrder,
      this.disabledPackageQuanity = false});

  @override
  Widget build(BuildContext context) {
    return BaseParaPharmaCatalogDetailsScreen(
      paraPharmaCatalogId: paraPharmaCatalogId,
      canOrder: canOrder,
      needCartCubit: false,
      buttonSections: ButtonsSectionDeligate(
        quantitySectionAlignment: MainAxisAlignment.center,
        disabledPackageQuanity: disabledPackageQuanity,
      ),
    );
  }
}
