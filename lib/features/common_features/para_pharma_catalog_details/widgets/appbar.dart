import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

class ParaPharmaCatalogAppBar extends StatelessWidget {
  const ParaPharmaCatalogAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2(
      bgColor: AppColors.accent1Shade2.withAlpha(200),
      leading: IconButton(
        icon: Icon(
          Directionality.of(context) == TextDirection.rtl
              ? Iconsax.arrow_right_3
              : Iconsax.arrow_left_2,
          size: AppSizesManager.iconSize25,
          color: AppColors.bgWhite,
        ),
        onPressed: RoutingManager.router.popOrGoHome,
      ),
      trailing: [
        BlocBuilder<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<ParaPharmaDetailsCubit>(context);
            final gCubit = MarketPlaceScreen
                .marketPlaceScaffoldKey.currentContext!
                .read<ParaPharmaCubit>();
            final hCubit =
                HomeScreen.scaffoldKey.currentContext!.read<ParaPharmaCubit>();

            final isLiked = cubit.paraPharmaCatalogData?.isLiked ?? false;

            return IconButton(
              icon: Icon(
                isLiked ? Iconsax.heart5 : Iconsax.heart,
                color: isLiked ? Colors.red : Colors.white,
              ),
              onPressed: () {
                if (isLiked) {
                  cubit.unlikeParaPharma().then((liked) {
                    gCubit.refreshParaPharmaCatalogFavorite(
                        cubit.paraPharmaCatalogData!.id, liked);
                    hCubit.refreshParaPharmaCatalogFavorite(
                        cubit.paraPharmaCatalogData!.id, liked);
                  });
                } else {
                  cubit.likeParaPharma().then((liked) {
                    gCubit.refreshParaPharmaCatalogFavorite(
                        cubit.paraPharmaCatalogData!.id, liked);
                    hCubit.refreshParaPharmaCatalogFavorite(
                        cubit.paraPharmaCatalogData!.id, liked);
                  });
                }
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Iconsax.share,
            color: Colors.white,
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
}
