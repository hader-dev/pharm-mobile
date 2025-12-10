import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/sub_pages/gallery/cubit/gallery_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/sub_pages/gallery/widget/gallery_items_section.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/sub_pages/gallery/widget/interactive_image_view.dart';
import 'package:hader_pharm_mobile/models/gallery.dart';

import '../cubit/medicine_details_cubit.dart';

class MedicineProductPhotoSection extends StatelessWidget {
  const MedicineProductPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MedicineDetailsCubit>(context);

    final List<GalleryItem> galleryItems = [
      GalleryItem(imgPath: cubit.state.medicineCatalogData.image?.path ?? ""),
      ...cubit.state.medicineCatalogData.gallery!.items
    ];

    return BlocProvider(
        create: (context) => GalleryCubit(),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            BlocBuilder<GalleryCubit, GalleryState>(
                buildWhen: (previous, current) => current is SelectedGalleryChanged,
                builder: (context, state) {
                  return PageView(
                      controller: context.read<GalleryCubit>().pageController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) {
                        context.read<GalleryCubit>().changeSelectedGallery(value);
                      },
                      physics: const BouncingScrollPhysics(),
                      children: galleryItems
                          .map((item) => InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => ProductInteractivePictures(
                                          pictureUrl: getItInstance.get<INetworkService>().getFilesPath(
                                              galleryItems[context.read<GalleryCubit>().selectedGalleryIndex]
                                                  .imgPath)));
                                },
                                child: CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
                                  width: double.maxFinite,
                                  height: MediaQuery.of(context).size.width > 768 ? 400 : 320,
                                  imageUrl: getItInstance.get<INetworkService>().getFilesPath(
                                      galleryItems[context.read<GalleryCubit>().selectedGalleryIndex].imgPath),
                                  fit: BoxFit.cover,
                                  errorImgSize: MediaQuery.of(context).size.width > 768 ? 400 * .4 : 320 * .4,
                                  errorMsg: "No Image Available",
                                ),
                              ))
                          .toList());
                }),
            if (cubit.state.medicineCatalogData.gallery!.items.isNotEmpty)
              GalleryItemsSection(galleryItems: galleryItems)
          ],
        ));
  }
}
