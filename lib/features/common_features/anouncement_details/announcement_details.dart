import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/widgets/tabs_section.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  static final announcementDetailsScafoldKey = GlobalKey<ScaffoldState>();
  final String announcementId;

  const AnnouncementDetailsScreen({super.key, required this.announcementId});

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
            create: (context) => AnnouncementCubit(
                announcementId: announcementId,
                promotionRepository: PromotionRepository(
                    client: getItInstance.get<INetworkService>()),
                favoriteRepository: FavoriteRepository(
                    client: getItInstance.get<INetworkService>()),
                scrollController: ScrollController())
              ..loadAnnouncement())
      ],
      child: Scaffold(
          key: announcementDetailsScafoldKey,
          appBar: AnnouncementDetailsAppbar(
            customAppbarHeight:
                context.deviceSize.width <= DeviceSizes.largeMobile.width
                    ? kToolbarHeight
                    : kToolbarHeight * 2,
          ),
          body: AnnouncementDetailsTabBarSection()),
    );
  }
}
