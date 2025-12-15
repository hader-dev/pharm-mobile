import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
// import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

class ParapharmaStateProvider extends StatelessWidget {
  final Widget child;

  const ParapharmaStateProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      // BlocProvider(
      //   create: (_) => ParaMedicalFiltersCubit(
      //     filtersRepository: getItInstance.get<IFiltersRepository>(),
      //   ),
      // ),
      BlocProvider(
        create: (context) => ParaPharmaCubit(
          scrollController: ScrollController(),
          favoriteRepository: FavoriteRepository(client: getItInstance.get<INetworkService>()),
          searchController: TextEditingController(text: ""),
          paraPharmaRepository: ParaPharmaRepository(
            client: getItInstance.get<INetworkService>(),
          ),
        )..getParaPharms(),
      ),
    ], child: child);
  }
}
