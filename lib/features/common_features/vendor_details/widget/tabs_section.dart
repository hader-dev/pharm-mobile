import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/vendor_details/cubit/vendor_details_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../subPages/about_vendor/about_vendor.dart';
import '../subPages/medicines/medicines.dart';
import '../subPages/para_pharma/para_pharma.dart';

class VandorDetailsTabBarSection extends StatefulWidget {
  final List<String> tabs = [
    "About",
    "Medicine",
    "Para-Pharma",
  ];
  VandorDetailsTabBarSection({super.key, required this.companyId});
  final String companyId;

  @override
  State<VandorDetailsTabBarSection> createState() =>
      _VandorDetailsTabBarSectionState();
}

class _VandorDetailsTabBarSectionState extends State<VandorDetailsTabBarSection>
    with TickerProviderStateMixin {
  late final TabController tabsController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle tabTextStyle = context.responsiveTextTheme.current.body3Medium;

    return Column(
      children: [
        ColoredBox(
          color: AppColors.accent1Shade2,
          child: TabBar(
              indicatorColor: AppColors.bgWhite,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              labelStyle: tabTextStyle,
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              tabAlignment: TabAlignment.start,
              labelColor: AppColors.bgWhite,
              unselectedLabelColor: AppColors.accent1Shade2Deemphasized,
              controller: tabsController,
              tabs: widget.tabs
                  .map(
                    (tabLabel) => Tab(
                      child: Text(
                        tabLabel,
                      ),
                    ),
                  )
                  .toList()),
        ),
        Gap(AppSizesManager.s16),
        Expanded(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => MedicineProductsCubit(
                    scrollController: ScrollController(),
                    favoriteRepository: FavoriteRepository(
                        client: getItInstance.get<INetworkService>()),
                    searchController: TextEditingController(text: ""),
                    medicineRepository: MedicineCatalogRepository(
                        client: getItInstance.get<INetworkService>()))
                  ..getMedicines(companyIdFilter: widget.companyId),
              ),
              BlocProvider(
                create: (context) => ParaPharmaCubit(
                    favoriteRepository: FavoriteRepository(
                        client: getItInstance.get<INetworkService>()),
                    scrollController: ScrollController(),
                    searchController: TextEditingController(text: ""),
                    paraPharmaRepository: ParaPharmaRepository(
                        client: getItInstance.get<INetworkService>()))
                  ..getParaPharmas(companyIdFilter: widget.companyId),
              ),
            ],
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabsController,
              children: [
                VendorDetailsPage(
                    vendorData: BlocProvider.of<VendorDetailsCubit>(context)
                        .vendorData),
                MedicinesPage(),
                ParapharmaPage()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
