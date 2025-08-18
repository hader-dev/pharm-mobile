import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../common/app_bars/custom_app_bar.dart';
import '../cubit/medicine_details_cubit.dart';

class MedicineProductPhotoSection extends StatelessWidget {
  const MedicineProductPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CacheNetworkImagePlus(
          height: 320,
          width: double.maxFinite,
          boxFit: BoxFit.fill,
          imageUrl: BlocProvider.of<MedicineDetailsCubit>(context)
                      .medicineCatalogData
                      ?.image !=
                  null
              ? getItInstance.get<INetworkService>().getFilesPath(
                  BlocProvider.of<MedicineDetailsCubit>(context)
                      .medicineCatalogData!
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
                style: AppTypography.body3MediumStyle
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
              ),
              onPressed: RoutingManager.router.popOrGoHome,
            ),
            trailing: [
              BlocBuilder<MedicineDetailsCubit, MedicineDetailsState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<MedicineDetailsCubit>(context);
                  final isLiked = cubit.medicineCatalogData?.isLiked ?? false;

                  return IconButton(
                    icon: Icon(
                      isLiked ? Iconsax.heart5 : Iconsax.heart,
                      color: isLiked ? Colors.red : Colors.black,
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
                icon: const Icon(Iconsax.share),
                onPressed: () {
                  final cubit = BlocProvider.of<MedicineDetailsCubit>(context);
                  cubit.shareProduct();
                },
              ),
            ],
            title: SizedBox.shrink()),
      ],
    );
  }
}
