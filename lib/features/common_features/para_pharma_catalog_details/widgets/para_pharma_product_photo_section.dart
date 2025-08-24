import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ParaPharmaProductPhotoSection extends StatelessWidget {
  const ParaPharmaProductPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CacheNetworkImagePlus(
          height: 320,
          width: double.maxFinite,
          boxFit: BoxFit.fill,
          imageUrl: BlocProvider.of<ParaPharmaDetailsCubit>(context)
                      .paraPharmaCatalogData
                      ?.image !=
                  null
              ? getItInstance.get<INetworkService>().getFilesPath(
                  BlocProvider.of<ParaPharmaDetailsCubit>(context)
                      .paraPharmaCatalogData!
                      .image!
                      .path)
              : "",
          errorWidget: Column(
            children: [
              Spacer(),
              Icon(Iconsax.image,
                  color: Color.fromARGB(255, 197, 197, 197),
                  size: AppSizesManager.iconSize30),
              Gap(AppSizesManager.s8),
              Text(
                context.translation!.image_not_available,
                style: context.responsiveTextTheme.current.body3Medium
                    .copyWith(color: const Color.fromARGB(255, 197, 197, 197)),
              ),
              Spacer(),
            ],
          ),
        ),
        CustomAppBar(
            bgColor: Colors.transparent,
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
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
                  final cubit =
                      BlocProvider.of<ParaPharmaDetailsCubit>(context);
                  final isLiked = cubit.paraPharmaCatalogData?.isLiked ?? false;

                  return IconButton(
                    icon: Icon(
                      isLiked ? Iconsax.heart5 : Iconsax.heart,
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      if (isLiked) {
                        cubit.unlikeParaPharma();
                      } else {
                        cubit.likeParaPharma();
                      }
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Iconsax.share),
                onPressed: () {
                  final cubit =
                      BlocProvider.of<ParaPharmaDetailsCubit>(context);
                  cubit.shareProduct();
                },
              ),
            ],
            title: SizedBox.shrink()),
      ],
    );
  }
}
