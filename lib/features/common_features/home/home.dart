import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/medicine/medicine_section.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/parapharm/para_pharma_section.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/vendors/vendors_section.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import 'widgets/announcements/promotion_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minSectionHeight = MediaQuery.of(context).size.height * 0.15;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
              announcementsRepo: PromotionRepository(
                  client: getItInstance.get<INetworkService>()))
            ..getPromotions(),
        ),
        BlocProvider(
          create: (context) => VendorsCubit(
            companyRepository:
                CompanyRepository(client: getItInstance.get<INetworkService>()),
            scrollController: ScrollController(),
            searchController: TextEditingController(text: ""),
          )..fetchVendors(),
        ),
        BlocProvider(
            create: (context) => MedicineProductsCubit(
                scrollController: ScrollController(),
                favoriteRepository: FavoriteRepository(
                    client: getItInstance.get<INetworkService>()),
                searchController: TextEditingController(text: ""),
                medicineRepository: MedicineCatalogRepository(
                    client: getItInstance.get<INetworkService>()))
              ..getMedicines()),
        BlocProvider(
            create: (context) => ParaPharmaCubit(
                scrollController: ScrollController(),
                favoriteRepository: FavoriteRepository(
                    client: getItInstance.get<INetworkService>()),
                searchController: TextEditingController(text: ""),
                paraPharmaRepository: ParaPharmaRepository(
                    client: getItInstance.get<INetworkService>()))
              ..getParaPharmas()),
      ],
      child: Scaffold(
        appBar: HomeAppbar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is PromotionLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PromotionLoadingFailed) {
              return Center(
                child: EmptyListWidget(
                  onRefresh: () {
                    context.read<HomeCubit>().getPromotions();
                  },
                ),
              );
            }

            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(AppSizesManager.s12),
                PromotionSection(
                  announcements: context.read<HomeCubit>().announcements,
                ),
                Gap(AppSizesManager.s16),
                VendorSection(
                    minSectionHeight:
                        context.read<VendorsCubit>().vendorsList.length < 4
                            ? minSectionHeight * 0.8
                            : minSectionHeight),
                // Ultra-minimal spacing between vendors and medicines for phones
                SizedBox(height: MediaQuery.of(context).size.width <= 414 ? 1 : 12),
                MedicineSection(minSectionHeight: minSectionHeight),
                Gap(AppSizesManager.s12),
                ParapharmaSection(minSectionHeight: minSectionHeight),
                Gap(AppSizesManager.s12),
              ],
            ));
          },
        ),
      ),
    );
  }
}
