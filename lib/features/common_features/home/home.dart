import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/services/notification/notification_service_port.dart';
import 'package:hader_pharm_mobile/config/services/notification/utility/mock_remote_message.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/di/di.dart';
import '../../../config/services/network/network_interface.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../repositories/remote/favorite/favorite_repository_impl.dart';
import '../../../repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import '../../../repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import '../../../utils/constants.dart';
import '../../common/app_bars/custom_app_bar.dart';
import '../market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'widgets/medicine_section.dart';
import 'widgets/para_pharma_section.dart';
import 'widgets/promotion_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
              announcementsRepo: PromotionRepository(
                  client: getItInstance.get<INetworkService>()))
            ..getPromotions(),
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
          appBar: CustomAppBar(
            bgColor: AppColors.bgWhite,
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            leading: IconButton(
              icon: const Icon(
                Iconsax.home,
                size: AppSizesManager.iconSize25,
              ),
              onPressed: () {},
            ),
            title: Text(
              context.translation!.home,
              style: AppTypography.headLine3SemiBoldStyle,
            ),
            trailing: [
              IconButton(
                icon: const Icon(Iconsax.notification),
                onPressed: () {},
              ),
            ],
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is PromotionLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PromotionLoadingFailed) {
                return const Text('Failed to load promotions');
              }
              return ListView(
                shrinkWrap: true,
                children: [
                  PromotionSection(
                    promotionsUrls: context
                        .read<HomeCubit>()
                        .announcements
                        .map((e) => e.imgPath)
                        .toList(),
                  ),
                  Gap(AppSizesManager.s12),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              DrawableAssetStrings.medicinesBg,
                            ),
                            fit: BoxFit.cover,
                            opacity: 0.3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(AppSizesManager.s4),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: AppSizesManager.p6),
                          child: Text(
                            context.translation!.medicines,
                            style: AppTypography.headLine5SemiBoldStyle,
                          ),
                        ),
                        MedicinesSection(),
                      ],
                    ),
                  ),
                  Gap(AppSizesManager.s16),

                  // CategoriesSection(),

                  DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              DrawableAssetStrings.paraPharmsBg,
                            ),
                            fit: BoxFit.cover,
                            opacity: 0.3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(AppSizesManager.s4),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: AppSizesManager.p6),
                          child: Text(
                            context.translation!.para_pharma,
                            style: AppTypography.headLine5SemiBoldStyle,
                          ),
                        ),
                        Gap(AppSizesManager.s12),
                        //  BrandsSection(),
                        Gap(AppSizesManager.s8),
                        ParaPharmaSection(),
                      ],
                    ),
                  ),
                  Gap(AppSizesManager.s12),
                ],
              );
            },
          )),
    );
  }
}
