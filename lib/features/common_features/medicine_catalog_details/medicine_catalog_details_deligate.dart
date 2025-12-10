import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/medicine_catalog_details.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/button_sections/buttons_section_deligate.dart';

class MedicineCatalogDetailsDeligateScreen extends StatelessWidget {
  final String medicineCatalogId;
  final bool canOrder;
  final bool disabledPackageQuanity;
  static final GlobalKey<ScaffoldState> medicineDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();
  final String buyerCompanyId;

  const MedicineCatalogDetailsDeligateScreen(
      {super.key,
      required this.medicineCatalogId,
      required this.canOrder,
      required this.buyerCompanyId,
      this.disabledPackageQuanity = false});

  @override
  Widget build(BuildContext context) {
    return BaseMedicineCatalogDetailsScreen(
      medicineCatalogId: medicineCatalogId,
      canOrder: canOrder,
      needCartCubit: false,
      buyerCompanyId: buyerCompanyId,
      quantitySectionBuilder: (double price) => ButtonsSectionDeligate(
        quantitySectionAlignment: MainAxisAlignment.center,
        onAction: () {
          context.pop();
          RoutingManager.router.pop();
        },
        disabledPackageQuanity: disabledPackageQuanity,
        price: price,
      ),
    );
  }
}
