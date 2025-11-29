import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';

import '../../../common/image/cached_network_image_with_asset_fallback.dart'
    show CachedNetworkImageWithDrawableFallback;

class ParaPharmaProductPhotoSection extends StatelessWidget {
  const ParaPharmaProductPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ParaPharmaDetailsCubit>();
    return CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.width > 768 ? 400 : 320,
      imageUrl: getItInstance
          .get<INetworkService>()
          .getFilesPath(cubit.state.paraPharmaCatalogData.image?.path ?? ""),
      fit: BoxFit.cover,
      errorImgSize:
          MediaQuery.of(context).size.width > 768 ? 400 * .4 : 320 * .4,
      errorMsg: "No Image Available",
    );
    // ? CacheNetworkImagePlus(
    //     height:
    //     width: double.maxFinite,
    //     boxFit: BoxFit.contain,
    //     imageUrl: cubit.state.paraPharmaCatalogData.image != null
    //         ? getItInstance.get<INetworkService>().getFilesPath(
    //             BlocProvider.of<ParaPharmaDetailsCubit>(context)
    //                 .state
    //                 .paraPharmaCatalogData
    //                 .image!
    //                 .path)
    //         : "",
    //     errorWidget: Column(
    //       children: [
    //         const Spacer(),
    //         Icon(Iconsax.image,
    //             color: Color.fromARGB(255, 197, 197, 197),
    //             size: context.responsiveAppSizeTheme.current.iconSize30),
    //         const ResponsiveGap.s8(),
    //         Text(
    //           context.translation!.image_not_available,
    //           style: context.responsiveTextTheme.current.body3Medium
    //               .copyWith(
    //                   color: const Color.fromARGB(255, 197, 197, 197)),
    //         ),
    //       ],
    //     ),
    //   )
    // : Image(
    //     image: AssetImage(DrawableAssetStrings.paraPharmaPlaceHolderImg),
    //     fit: BoxFit.cover,
    //     height: 320,
    //     width: double.maxFinite,
    //   );
  }
}
