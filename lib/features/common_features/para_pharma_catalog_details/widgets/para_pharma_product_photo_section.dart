import 'package:flutter/material.dart';
import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/di/di.dart';
import '../../../../config/services/network/network_interface.dart';
import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../common/app_bars/custom_app_bar.dart';
import '../cubit/para_pharma_details_cubit.dart';

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
          imageUrl: BlocProvider.of<ParaPharmaDetailsCubit>(context).paraPharmaCatalogData?.image != null
              ? getItInstance
                  .get<INetworkService>()
                  .getFilesPath(BlocProvider.of<ParaPharmaDetailsCubit>(context).paraPharmaCatalogData!.image!.path)
              : "",
          errorWidget: Column(
            children: [
              Spacer(),
              Icon(Iconsax.image, color: Color.fromARGB(255, 197, 197, 197), size: AppSizesManager.iconSize30),
              Gap(AppSizesManager.s8),
              Text(
                "Image not available",
                style: AppTypography.body3MediumStyle.copyWith(color: const Color.fromARGB(255, 197, 197, 197)),
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
                Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
                size: AppSizesManager.iconSize25,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            trailing: [
              IconButton(
                icon: const Icon(Iconsax.heart),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Iconsax.share),
                onPressed: () {},
              ),
            ],
            title: SizedBox.shrink()),
      ],
    );
  }
}
