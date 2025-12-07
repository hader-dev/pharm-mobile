import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ParaPharmaCatalogAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ParaPharmaCatalogAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = context.deviceSize.width <= DeviceSizes.largeMobile.width
        ? context.responsiveAppSizeTheme.current.iconSize30
        : context.responsiveAppSizeTheme.current.iconSize18;

    return CustomAppBarV2.normal(
      leading: IconButton(
        iconSize: iconSize,
        icon: Icon(
          Directionality.of(context) == TextDirection.rtl
              ? Iconsax.arrow_right_3
              : Iconsax.arrow_left_2,
          color: AppColors.accent1Shade1,
          size: iconSize,
        ),
        onPressed: RoutingManager.router.popOrGoHome,
      ),
      trailing: [
        BlocBuilder<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<ParaPharmaDetailsCubit>(context);

            final hCubit =
                HomeScreen.scaffoldKey.currentContext?.read<ParaPharmaCubit>();

            final isLiked = cubit.state.paraPharmaCatalogData.isLiked;

            return IconButton(
              icon: Icon(
                isLiked ? Iconsax.heart5 : Iconsax.heart,
                color: isLiked ? Colors.red : Colors.grey,
                size: context.responsiveAppSizeTheme.current.iconSize25,
              ),
              onPressed: () {
                if (isLiked) {
                  cubit.unlikeParaPharma().then((liked) {
                    hCubit?.refreshParaPharmaCatalogFavorite(
                        cubit.state.paraPharmaCatalogData.id, liked);
                  });
                } else {
                  cubit.likeParaPharma().then((liked) {
                    hCubit?.refreshParaPharmaCatalogFavorite(
                        cubit.state.paraPharmaCatalogData.id, liked);
                  });
                }
              },
            );
          },
        ),
        IconButton(
          icon: Icon(
            LucideIcons.share2,
            color: AppColors.accent1Shade1,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
          onPressed: () {
            final cubit = BlocProvider.of<ParaPharmaDetailsCubit>(context);
            cubit.shareProduct();
          },
        ),
      ],
      title: SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
