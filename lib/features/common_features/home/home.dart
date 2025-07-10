import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/home/cubit/home_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/announcement_repository_impl.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/di/di.dart';
import '../../../config/services/network/network_interface.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../utils/constants.dart';
import '../../common/app_bars/custom_app_bar.dart';
import 'widgets/promotion_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(announcementsRepo: PromotionRepository(client: getItInstance.get<INetworkService>()))
            ..getPromotions(),
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
            title: const Text(
              "Home",
              style: AppTypography.headLine3SemiBoldStyle,
            ),
            trailing: [
              IconButton(
                icon: const Icon(Iconsax.search_normal),
                onPressed: () {},
              ),
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
              return Column(
                children: [
                  PromotionSection(
                    promotionsUrls: context.read<HomeCubit>().announcements.map((e) => e.imgPath).toList(),
                  ),
                ],
              );
            },
          )),
    );
  }
}
