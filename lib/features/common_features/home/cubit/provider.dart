import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

class StateProvider extends StatelessWidget {
  const StateProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            HomeCubit(announcementsRepo: PromotionRepository(client: getItInstance.get<INetworkService>()))
              ..getPromotions(
                limit: 5,
              ),
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
      BlocProvider(
          create: (context) => MedicineProductsCubit(
              scrollController: ScrollController(),
              favoriteRepository: FavoriteRepository(client: getItInstance.get<INetworkService>()),
              searchController: TextEditingController(text: ""),
              medicineRepository: MedicineCatalogRepository(client: getItInstance.get<INetworkService>()))
            ..getMedicines()),
      BlocProvider(
          create: (context) => ParaPharmaCubit(
              scrollController: ScrollController(),
              favoriteRepository: FavoriteRepository(client: getItInstance.get<INetworkService>()),
              searchController: TextEditingController(text: ""),
              paraPharmaRepository: ParaPharmaRepository(client: getItInstance.get<INetworkService>()))
            ..getParaPharms()),
    ], child: child);
  }
}
