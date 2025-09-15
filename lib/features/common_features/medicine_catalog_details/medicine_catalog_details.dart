import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/helpers/medicine_catalog_details_tab_data.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/sub_pages/distribitor_details/distributor_details.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/sub_pages/medcine_catalog_overview/medcine_catalog_overview.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/buttons_section.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import 'cubit/medicine_details_cubit.dart';
import 'widgets/header_section.dart';
import 'widgets/medicine_product_photo_section.dart';
import 'widgets/tap_bar_section.dart';

class MedicineCatalogDetailsScreen extends StatefulWidget {
  final String medicineCatalogId;
  static final GlobalKey<ScaffoldState> medicineDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();
  const MedicineCatalogDetailsScreen(
      {super.key, required this.medicineCatalogId});

  @override
  State<MedicineCatalogDetailsScreen> createState() =>
      _MedicineCatalogDetailsScreenState();
}

class _MedicineCatalogDetailsScreenState
    extends State<MedicineCatalogDetailsScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final tabs = medicineCatalogDetailsTabData(context);

    return SafeArea(
      child: StateProvider(
        tabs: tabs,
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
                        ProductDetailsTabBarSection(),
                        const ResponsiveGap.s24(),
                        if (BlocProvider.of<MedicineDetailsCubit>(context)
                                .tabController
                                .index ==
                            0)
                          MedicineOverViewPage(),
                        if (BlocProvider.of<MedicineDetailsCubit>(context)
                                .tabController
                                .index ==
                            1)
                          DistributorDetailsPage(),
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
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(AppSizesManager.p12),
                child: SizedBox(
                  height: kBottomNavigationBarHeight * 3,
                  child: ButtonsSection(
                    medicineDetailsCubit: context.read<MedicineDetailsCubit>(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
