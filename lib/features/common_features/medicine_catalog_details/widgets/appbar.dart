import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

class MedicineCatalogAppBar extends StatelessWidget {
  const MedicineCatalogAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2(
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
            final isLiked = cubit.state.medicineCatalogData?.isLiked ?? false;

            return IconButton(
              icon: Icon(
                isLiked ? Iconsax.heart5 : Iconsax.heart,
                color: isLiked ? Colors.red : Colors.white,
              ),
              onPressed: () {
                if (isLiked) {
                  cubit.unlikeMedicine();
                } else {
                  cubit.likeMedicine();
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
