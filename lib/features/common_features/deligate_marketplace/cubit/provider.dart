import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/cubit/marketplace_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

class DeligateMarketPlaceStateProvider extends StatelessWidget {
  final Widget child;
  final DeligateClient client;
  const DeligateMarketPlaceStateProvider({
    super.key,
    required this.child,
    required this.client,
  });

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
              buyerCompanyId: client.buyerCompanyId,
              scrollController: ScrollController(),
              favoriteRepository: FavoriteRepository(
                  client: getItInstance.get<INetworkService>()),
              searchController: TextEditingController(text: ""),
              paraPharmaRepository: ParaPharmaRepository(
                  client: getItInstance.get<INetworkService>()))
            ..getParaPharmas(),
        ),
        BlocProvider(
          create: (context) => DeligateMarketplaceCubit(
            client: client,
            orderRepo: OrderRepository(
              client: getItInstance.get<INetworkService>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DeligateCreateOrderCubit(
            shippingAddress:
                getItInstance.get<UserManager>().currentUser.address,
            parapharmaRepo: ParaPharmaRepository(
              client: getItInstance.get<INetworkService>(),
            ),
            orderRepo: OrderRepository(
              client: getItInstance.get<INetworkService>(),
            ),
            scrollController: ScrollController(),
            packageQuantityController: TextEditingController(text: "0"),
            searchController: TextEditingController(),
            quantityController: TextEditingController(text: "1"),
            customPriceController: TextEditingController(),
          ),
        ),
      ],
      child: child,
    );
  }
}
