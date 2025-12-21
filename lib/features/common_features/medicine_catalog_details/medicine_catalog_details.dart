import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/sub_pages/medcine_catalog_overview/medcine_catalog_overview.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/appbar.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'cubit/medicine_details_cubit.dart';
import 'widgets/header_section.dart';
import 'widgets/medicine_product_photo_section.dart';

typedef QuantitySectionBuilder = Widget Function(double unitPrice);

class BaseMedicineCatalogDetailsScreen extends StatefulWidget {
  final String medicineCatalogId;
  final bool disabledPackageQuanity;
  final bool canOrder;
  final bool needCartCubit;
  final QuantitySectionBuilder quantitySectionBuilder;
  final String? buyerCompanyId;

  static final GlobalKey<ScaffoldState> medicineDetailsScaffoldKey = GlobalKey<ScaffoldState>();
  const BaseMedicineCatalogDetailsScreen(
      {super.key,
      required this.medicineCatalogId,
      required this.canOrder,
      this.buyerCompanyId,
      required this.needCartCubit,
      required this.quantitySectionBuilder,
      this.disabledPackageQuanity = false});

  @override
  State<BaseMedicineCatalogDetailsScreen> createState() => _BaseMedicineCatalogDetailsScreenState();
}

class _BaseMedicineCatalogDetailsScreenState extends State<BaseMedicineCatalogDetailsScreen>
    with TickerProviderStateMixin {
  double bottomNavbarHeightModifier = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bottomNavbarHeightModifier = widget.disabledPackageQuanity
        ? context.responsiveAppSizeTheme.current.deafultQuantityNavbarHeightModifier
        : context.responsiveAppSizeTheme.current.expandedQuantityNavbarHeightModifier;

    return StateProvider(
      needCartCubit: widget.needCartCubit,
      tabs: const [],
      vsync: this,
      medicineCatalogId: widget.medicineCatalogId,
      buyerCompanyId: widget.buyerCompanyId,
      child: BlocBuilder<MedicineDetailsCubit, MedicineDetailsState>(
        builder: (context, state) {
          if (state is MedicineDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MedicineDetailsLoadError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(
                  color: AppColors.accent1Shade1,
                ),
                Expanded(child: Center(child: EmptyListWidget())),
              ],
            );
          }
          return Scaffold(
            appBar: const MedicineCatalogAppBar(),
            key: BaseMedicineCatalogDetailsScreen.medicineDetailsScaffoldKey,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const MedicineProductPhotoSection(),
                    const HeaderSection(),
                    const Divider(color: AppColors.bgDisabled, thickness: 3.5, height: 1),
                    const ResponsiveGap.s24(),
                    MedicineOverViewPage(),
                    const ResponsiveGap.s24(),
                    Divider(color: AppColors.bgDisabled, thickness: 3.5, height: 1),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: kBottomNavigationBarHeight,
              child: widget.canOrder
                  ? widget.quantitySectionBuilder(state.medicineCatalogData.unitPriceHt)
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
