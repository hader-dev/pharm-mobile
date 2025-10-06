import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

class MedicineCatalogAppBar extends StatelessWidget {
  const MedicineCatalogAppBar({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2(
      height: height,
      width: width,
      bgColor: AppColors.accent1Shade2.withAlpha(200),
      leading: IconButton(
        icon: Icon(
          Directionality.of(context) == TextDirection.rtl
              ? Iconsax.arrow_right_3
              : Iconsax.arrow_left_2,
          color: AppColors.bgWhite,
          size: AppSizesManager.iconSize25,
        ),
        onPressed: RoutingManager.router.popOrGoHome,
      ),
      trailing: [
        BlocBuilder<MedicineDetailsCubit, MedicineDetailsState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<MedicineDetailsCubit>(context);
            final gCubit = MarketPlaceScreen
                .marketPlaceScaffoldKey.currentContext!
                .read<MedicineProductsCubit>();
            final hCubit = HomeScreen.scaffoldKey.currentContext!
                .read<MedicineProductsCubit>();
            final isLiked = cubit.state.medicineCatalogData?.isLiked ?? false;

            return IconButton(
              icon: Icon(
                isLiked ? Iconsax.heart5 : Iconsax.heart,
                color: isLiked ? Colors.red : Colors.white,
              ),
              onPressed: () {
                if (isLiked) {
                  cubit.unlikeMedicine().then((value) {
                    gCubit.refreshMedicineCatalogFavorite(
                        state.medicineCatalogData!.id, false);
                    hCubit.refreshMedicineCatalogFavorite(
                        state.medicineCatalogData!.id, false);
                  });
                } else {
                  cubit.likeMedicine().then((value) {
                    gCubit.refreshMedicineCatalogFavorite(
                        state.medicineCatalogData!.id, true);
                    hCubit.refreshMedicineCatalogFavorite(
                        state.medicineCatalogData!.id, true);
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
            final cubit = BlocProvider.of<MedicineDetailsCubit>(context);
            cubit.shareProduct();
          },
        ),
      ],
      title: SizedBox.shrink(),
    );
  }
}
