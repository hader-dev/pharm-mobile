import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/cubit/announcement_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/widgets/tabs_section.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

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
          appBar: CustomAppBarV2.alternate(
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            leading: IconButton(
              icon: const Icon(
                Iconsax.arrow_left,
                color: Colors.white,
                size: AppSizesManager.iconSize25,
              ),
              onPressed: () => context.pop(),
            ),
            title: Text(
              context.translation!.announcement_details,
              style: AppTypography.headLine3SemiBoldStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          body: AnnouncementDetailsTabBarSection()),
    );
  }
}
