import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';

import '../cubit/medicine_details_cubit.dart';

class MedicineProductPhotoSection extends StatelessWidget {
  const MedicineProductPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MedicineDetailsCubit>(context);

    return CachedNetworkImageWithDrawableFallback.withErrorAssetImage(
      errorAssetImagePath: DrawableAssetStrings.medicinePlaceHolderImg,
      imageUrl: cubit.state.medicineCatalogData.image != null
          ? getItInstance.get<INetworkService>().getFilesPath(
                cubit.state.medicineCatalogData.image!.path,
              )
          : "",
      height: MediaQuery.of(context).size.width > 768 ? 400 : 320,
      width: double.maxFinite,
      fit: BoxFit.contain,
    );
  }
}
