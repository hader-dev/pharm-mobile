import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/sub_pages/gallery/cubit/gallery_cubit.dart'
    show GalleryCubit, GalleryState;
import 'package:hader_pharm_mobile/models/gallery.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class GalleryItemsSection extends StatelessWidget {
  final List<GalleryItem> galleryItems;

  const GalleryItemsSection({super.key, this.galleryItems = const []});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryCubit, GalleryState>(builder: (context, state) {
      return Container(
        margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p4,
          horizontal: context.responsiveAppSizeTheme.current.p4,
        ),
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(
              context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        ),
        constraints:
            const BoxConstraints(maxWidth: 45, maxHeight: double.maxFinite),
        child: ListView(shrinkWrap: true, children: [
          for (int index = 0; index < galleryItems.length; index++)
            InkWell(
              onTap: () =>
                  context.read<GalleryCubit>().changeSelectedGallery(index),
              child: GalleryItemWidget(
                galleryItem: galleryItems[index],
                isSelected:
                    index == context.read<GalleryCubit>().selectedGalleryIndex,
              ),
            )
        ]),
      );
    });
  }
}

class GalleryItemWidget extends StatelessWidget {
  final bool isSelected;
  final GalleryItem galleryItem;
  const GalleryItemWidget(
      {super.key, required this.galleryItem, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.s2,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
            width: isSelected ? 2.5 : 1,
          ),
          borderRadius:
              BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
          color: Colors.white,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withAlpha(100),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
            width: 40,
            height: 40,
            imageUrl: getItInstance
                .get<INetworkService>()
                .getFilesPath(galleryItem.imgPath)));
  }
}
