import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart' show getItInstance;
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/cubit/favorites_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/services/network/network_interface.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../repositories/remote/favorite/favorite_repository_impl.dart';
import '../../../utils/constants.dart';
import 'widget/tabs_section.dart';

class FavoritesScreen extends StatelessWidget {
  static final favoritesScaffoldKey = GlobalKey<ScaffoldState>();
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => FavoritesCubit(
            favoriteRepository: FavoriteRepository(
                client: getItInstance.get<INetworkService>()))
          ..fetchFavorites(),
        child: Scaffold(
            key: favoritesScaffoldKey,
            appBar: CustomAppBarV2.alternate(
              leading: IconButton(
                icon: Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? Iconsax.arrow_right_3
                      : Iconsax.arrow_left_2,
                  size: AppSizesManager.iconSize25,
                  color: AppColors.bgWhite,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
              title: Text(
                context.translation!.favorites,
                style: context.responsiveTextTheme.current.headLine3SemiBold
                    .copyWith(color: AppColors.bgWhite),
              ),
            ),
            body: FavoritesTabBarSection()),
      ),
    );
  }
}
