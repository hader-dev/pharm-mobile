import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'sub_pages/vendors/cubit/vendors_cubit.dart';
import 'widgets/tabs_section.dart';

class MarketPlaceScreen extends StatelessWidget {
  static final marketPlaceScaffoldKey = GlobalKey<ScaffoldState>();
  const MarketPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MedicineProductsCubit(
              scrollController: ScrollController(),
              favoriteRepository: FavoriteRepository(
                  client: getItInstance.get<INetworkService>()),
              searchController: TextEditingController(text: ""),
              medicineRepository: MedicineCatalogRepository(
                  client: getItInstance.get<INetworkService>()))
            ..getMedicines(),
        ),
        BlocProvider(
          create: (context) => ParaPharmaCubit(
              scrollController: ScrollController(),
              favoriteRepository: FavoriteRepository(
                  client: getItInstance.get<INetworkService>()),
              searchController: TextEditingController(text: ""),
              paraPharmaRepository: ParaPharmaRepository(
                  client: getItInstance.get<INetworkService>()))
            ..getParaPharmas(),
        ),
        BlocProvider(
          create: (context) => VendorsCubit(
            companyRepository:
                CompanyRepository(client: getItInstance.get<INetworkService>()),
            scrollController: ScrollController(),
            searchController: TextEditingController(text: ""),
          )..fetchVendors(),
        ),
      ],
      child: Scaffold(
          key: marketPlaceScaffoldKey,
          appBar: CustomAppBarV2.alternate(
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            leading: IconButton(
              icon: const Icon(
                Iconsax.shop,
                color: Colors.white,
                size: AppSizesManager.iconSize25,
              ),
              onPressed: () {},
            ),
            title: Text(
              context.translation!.market_place,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(
                color: Colors.white,
              ),
            ),
            trailing: [
              IconButton(
                icon: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return Badge.count(
                        count: AppLayout.appLayoutScaffoldKey.currentContext!
                            .read<CartCubit>()
                            .cartItems
                            .length,
                        offset: Offset(7, -9),
                        child: const Icon(
                          Iconsax.bag_2,
                          color: Colors.white,
                        ));
                  },
                ),
                onPressed: () {
                  AppLayout.appLayoutScaffoldKey.currentContext!
                      .read<AppLayoutCubit>()
                      .changePage(2);
                },
              ),
            ],
          ),
          body: MarketPlaceTabBarSection()),
    );
  }
}
