import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart' show getItInstance;
import 'package:hader_pharm_mobile/features/common_features/favorites/cubit/favorites_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/services/network/network_interface.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../repositories/remote/favorite/favorite_repository_impl.dart';
import '../../../utils/constants.dart';
import '../../common/app_bars/custom_app_bar.dart';
import 'widget/tabs_section.dart';

class FavoritesScreen extends StatelessWidget {
  static final favoritesScaffoldKey = GlobalKey<ScaffoldState>();
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            FavoritesCubit(favoriteRepository: FavoriteRepository(client: getItInstance.get<INetworkService>()))
              ..fetchFavorites(),
        child: Scaffold(
            key: favoritesScaffoldKey,
            appBar: CustomAppBar(
              bgColor: AppColors.bgWhite,
              topPadding: MediaQuery.of(context).padding.top,
              bottomPadding: MediaQuery.of(context).padding.bottom,
              leading: IconButton(
                icon: const Icon(
                  Iconsax.arrow_left_2,
                  size: AppSizesManager.iconSize25,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
              title: Text(
                context.translation!.favorites,
                style: AppTypography.headLine3SemiBoldStyle,
              ),
            ),
            body: FavoritesTabBarSection()),
      ),
    );
  }
}
