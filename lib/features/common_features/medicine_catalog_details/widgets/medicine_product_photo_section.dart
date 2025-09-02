import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/sub_pages/distribitor_details/widgets/trademark_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/appbar.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../cubit/medicine_details_cubit.dart';

class MedicineProductPhotoSection extends StatelessWidget {
  const MedicineProductPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MedicineDetailsCubit>(context);

    return Stack(
      children: [
        CachedNetworkImageWithAssetFallback(
          assetImage: DrawableAssetStrings.medicinePlaceHolderImg,
          imageUrl: cubit.state.medicineCatalogData?.image != null
              ? getItInstance.get<INetworkService>().getFilesPath(
                    cubit.state.medicineCatalogData!.image!.path,
                  )
              : "",
          height: 320,
          width: double.maxFinite,
          fit: BoxFit.fill,
        ),
        cubit.state.medicineCatalogData?.image != null
            ? CacheNetworkImagePlus(
                height: 320,
                width: double.maxFinite,
                boxFit: BoxFit.fill,
                imageUrl: cubit.state.medicineCatalogData?.image != null
                    ? getItInstance.get<INetworkService>().getFilesPath(
                        BlocProvider.of<MedicineDetailsCubit>(context)
                            .state
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
                    const ResponsiveGap.s8(),
                    Text(
                      context.translation!.image_not_available,
                      style: context.responsiveTextTheme.current.body3Medium
                          .copyWith(
                              color: const Color.fromARGB(255, 197, 197, 197)),
                    ),
                    Spacer(),
                  ],
                ),
              )
            : Image(
                image: AssetImage(DrawableAssetStrings.medicinePlaceHolderImg),
                fit: BoxFit.cover,
                height: 320,
                width: double.maxFinite,
              ),
        MedicineCatalogAppBar(),
        Positioned(bottom: 10, right: 10, child: TrademarkWidget())
      ],
    );
  }
}
