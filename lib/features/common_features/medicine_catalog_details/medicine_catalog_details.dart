import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/sub_pages/medcine_catalog_overview/medcine_catalog_overview.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/buttons_section.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import 'cubit/medicine_details_cubit.dart';
import 'widgets/header_section.dart';
import 'widgets/medicine_product_photo_section.dart';

class MedicineCatalogDetailsScreen extends StatefulWidget {
  final String medicineCatalogId;
  final bool disabledPackageQuanity;
  final bool canOrder;

  static final GlobalKey<ScaffoldState> medicineDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();
  const MedicineCatalogDetailsScreen(
      {super.key,
      required this.medicineCatalogId,
      required this.canOrder,
      this.disabledPackageQuanity = false});

  @override
  State<MedicineCatalogDetailsScreen> createState() =>
      _MedicineCatalogDetailsScreenState();
}

class _MedicineCatalogDetailsScreenState
    extends State<MedicineCatalogDetailsScreen> with TickerProviderStateMixin {
  double bottomNavbarHeightModifier = 1;

  @override
  void initState() {
    super.initState();
    bottomNavbarHeightModifier = widget.disabledPackageQuanity
        ? AppSizesManager.deafultQuantityNavbarHeightModifier
        : AppSizesManager.expendedQuantityNavbarHeightModifier;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StateProvider(
        tabs: const [],
        vsync: this,
        medicineCatalogId: widget.medicineCatalogId,
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
                  Center(child: EmptyListWidget()),
                ],
              );
            }
            return Scaffold(
              key: MedicineCatalogDetailsScreen.medicineDetailsScaffoldKey,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        MedicineProductPhotoSection(),
                        HeaderSection(),
                        Divider(
                            color: AppColors.bgDisabled,
                            thickness: 3.5,
                            height: 1),
                        const ResponsiveGap.s24(),
                        MedicineOverViewPage(),
                        const ResponsiveGap.s24(),
                        Divider(
                            color: AppColors.bgDisabled,
                            thickness: 3.5,
                            height: 1),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: const MedicineCatalogAppBar()),
                ],
              ),
              bottomNavigationBar: widget.canOrder
                  ? AnimatedPadding(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom +
                            AppSizesManager.p12,
                        left: AppSizesManager.p12,
                        right: AppSizesManager.p12,
                      ),
                      child: SizedBox(
                        height: kBottomNavigationBarHeight *
                            bottomNavbarHeightModifier,
                        child: ButtonsSection(
                          medicineDetailsCubit:
                              context.read<MedicineDetailsCubit>(),
                          quantitySectionAlignment: MainAxisAlignment.center,
                          disabledPackageQuanity: widget.disabledPackageQuanity,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
