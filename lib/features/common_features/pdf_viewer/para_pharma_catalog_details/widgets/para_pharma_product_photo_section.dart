import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/pdf_viewer/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/pdf_viewer/para_pharma_catalog_details/widgets/trademark_widget.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ParaPharmaProductPhotoSection extends StatelessWidget {
  const ParaPharmaProductPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ParaPharmaDetailsCubit>();
    return Stack(
      children: [
        cubit.paraPharmaCatalogData?.image != null
            ? CacheNetworkImagePlus(
                height: MediaQuery.of(context).size.width > 768 ? 400 : 320,
                width: double.maxFinite,
                boxFit: BoxFit.contain,
                imageUrl: cubit.paraPharmaCatalogData?.image != null
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
                    const ResponsiveGap.s8(),
                    Text(
                      context.translation!.image_not_available,
                      style: context.responsiveTextTheme.current.body3Medium
                          .copyWith(
                              color: const Color.fromARGB(255, 197, 197, 197)),
                    ),
                  ],
                ),
              )
            : Image(
                image:
                    AssetImage(DrawableAssetStrings.paraPharmaPlaceHolderImg),
                fit: BoxFit.cover,
                height: 320,
                width: double.maxFinite,
              ),
        Positioned(bottom: 10, right: 10, child: TrademarkWidget())
      ],
    );
  }
}
