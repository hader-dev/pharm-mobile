import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/featured.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/vendors/vendor_home_widget.dart'
    show VendorHomeWidget;
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/responsive/device_size.dart' show DeviceSizes, DeviceSizesExtension;

class VendorsSectionItems extends StatelessWidget {
  final int maxItemsPerRow;
  final int maxVisibleItems;
  final EdgeInsets padding;
  final double minSectionHeight;

  const VendorsSectionItems({
    super.key,
    this.maxItemsPerRow = 4,
    this.maxVisibleItems = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
    this.minSectionHeight = 250,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = _horizontalSpacing(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = _getItemWidth(context, spacing);

    return BlocBuilder<VendorsCubit, VendorsState>(
      builder: (context, state) {
        final items = state.vendorsList;

        if (state is VendorsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is VendorsLoadingFailed || items.isEmpty) {
          return Center(
            child: EmptyListWidget(),
          );
        }

        return Material(
          child: screenWidth <= DeviceSizes.largeMobile.width
              ? SizedBox(
                  height: minSectionHeight,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(min(maxVisibleItems, items.length), (index) {
                      final entity = items[index];
                      return VendorHomeWidget(
                        title: entity.name,
                        distributorCategory: entity.distributorCategory,
                        fallbackAssetImagePlaceholderPath: DrawableAssetStrings.companyPlaceHolderImg,
                        onPress: () => RoutingManager.router.pushNamed(
                          RoutingManager.vendorDetails,
                          extra: entity.id,
                        ),
                        imageUrl: getItInstance.get<INetworkService>().getFilesPath(
                              entity.thumbnailImage?.path ?? "",
                            ),
                      );
                    }),
                  ),
                )
              : Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: List.generate(min(maxVisibleItems, items.length), (index) {
                    final entity = items[index];
                    return FeaturedEntity(
                      size: itemWidth,
                      title: entity.name,
                      fallbackAssetImagePlaceholderPath: DrawableAssetStrings.companyPlaceHolderImg,
                      onPress: () => RoutingManager.router.pushNamed(
                        RoutingManager.vendorDetails,
                        extra: entity.id,
                      ),
                      imageUrl: getItInstance.get<INetworkService>().getFilesPath(
                            entity.thumbnailImage?.path ?? "",
                          ),
                    );
                  }),
                ),
        );
      },
    );
  }

  double _horizontalSpacing(BuildContext context) => context.responsiveAppSizeTheme.current.p8;

  double _getItemWidth(BuildContext context, double spacing) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = padding.left + padding.right;
    final totalSpacing = spacing * (maxItemsPerRow - 1);
    return (screenWidth - horizontalPadding - totalSpacing) / maxItemsPerRow;
  }
}
