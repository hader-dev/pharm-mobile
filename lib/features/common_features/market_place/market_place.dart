import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/widget/appbar.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

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
          create: (_) => MedicalFiltersCubit(
            filtersRepository: getItInstance.get<IFiltersRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) => ParaMedicalFiltersCubit(
            filtersRepository: getItInstance.get<IFiltersRepository>(),
          ),
        ),
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
            companyRepository: CompanyRepository(
              client: getItInstance.get<INetworkService>(),
              userManager: getItInstance.get<UserManager>(),
            ),
            scrollController: ScrollController(),
            searchController: TextEditingController(text: ""),
          )..fetchVendors(),
        ),
      ],
      child: Scaffold(
        key: marketPlaceScaffoldKey,
        appBar: MarketplaceAppbar(),
        body: MarketPlaceTabBarSection(),
      ),
    );
  }
}
