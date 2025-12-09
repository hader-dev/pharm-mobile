import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/cubit/all_announcements_cubit.dart';
// import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/medical_filters_cubit.dart';
// import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/vendor_details/cubit/vendor_details_cubit.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

class ParaPharmFilterProvider extends StatelessWidget {
  const ParaPharmFilterProvider({
    super.key,
    required this.child,
    required this.parapharmCubit,
    // required this.filterCubit,
  });

  final ParaPharmaCubit parapharmCubit;
  // final ParaMedicalFiltersCubit filterCubit;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider.value(
        //   value: filterCubit,
        // ),
        BlocProvider.value(
          value: parapharmCubit,
        ),
      ],
      child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(builder: (context, state) {
        return child;
      }),
    );
  }
}

class VendorDetailsProvider extends StatelessWidget {
  const VendorDetailsProvider({
    super.key,
    required this.child,
    required this.companyId,
  });

  final Widget child;
  final String companyId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VendorDetailsCubit(
            companyRepo: CompanyRepository(
              client: getItInstance.get<INetworkService>(),
              userManager: getItInstance.get<UserManager>(),
            ),
          )..getVendorDetails(companyId),
        ),
        // BlocProvider(
        //   create: (context) => ParaMedicalFiltersCubit(
        //     appliedFilters: ParaMedicalFilters(),
        //     filtersRepository: getItInstance.get<IFiltersRepository>(),
        //   ),
        // ),
        // BlocProvider(
        //   create: (context) => MedicalFiltersCubit(
        //     appliedFilters: MedicalFilters(
        //       vendors: [companyId],
        //     ),
        //     filtersRepository: getItInstance.get<IFiltersRepository>(),
        //   ),
        //  ),
        BlocProvider(
          create: (context) => AllAnnouncementsCubit(
            companyId: companyId,
            announcementsRepo: PromotionRepository(
              client: getItInstance.get<INetworkService>(),
            ),
            scrollController: ScrollController(),
            searchController: TextEditingController(),
          )..getAnnouncements(),
        ),
        BlocProvider(
          create: (context) => MedicineProductsCubit(
              filters: MedicalFilters(
                vendors: [companyId],
              ),
              scrollController: ScrollController(),
              favoriteRepository: FavoriteRepository(client: getItInstance.get<INetworkService>()),
              searchController: TextEditingController(text: ""),
              medicineRepository: MedicineCatalogRepository(client: getItInstance.get<INetworkService>()))
            ..getMedicines(
              filters: MedicalFilters(vendors: [companyId]),
            ),
        ),
        BlocProvider(
          create: (context) => ParaPharmaCubit(
              filters: ParaMedicalFilters(),
              scrollController: ScrollController(),
              favoriteRepository: FavoriteRepository(client: getItInstance.get<INetworkService>()),
              searchController: TextEditingController(text: ""),
              paraPharmaRepository: ParaPharmaRepository(client: getItInstance.get<INetworkService>()))
            ..getParaPharmas(
              filters: ParaMedicalFilters(),
            ),
        ),
      ],
      child: child,
    );
  }
}
