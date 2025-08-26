import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/featured.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

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
    final spacing = _horizontalSpacing();
    final itemWidth = _getItemWidth(context, spacing);

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: minSectionHeight * 2.2, minHeight: minSectionHeight),
      child: BlocBuilder<VendorsCubit, VendorsState>(
        builder: (context, state) {
          final items = context.read<VendorsCubit>().vendorsList;

          if (state is VendorsLoadingFailed || state is VendorsLoading) {
            return const Center(child: EmptyListWidget());
          }

          final visibleItems = items.take(maxVisibleItems).toList();

          return Material(
            child: Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children:
                  List.generate(min(maxVisibleItems, items.length), (index) {
                final entity = visibleItems[index];
                return SizedBox(
                  width: itemWidth,
                  child: FeaturedEntity(
                    size: itemWidth,
                    title: entity.name,
                    onPress: () => RoutingManager.router.pushNamed(
                      RoutingManager.vendorDetails,
                      extra: entity.id,
                    ),
                    imageUrl: getItInstance.get<INetworkService>().getFilesPath(
                          entity.thumbnailImage!.path,
                        ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  double _horizontalSpacing() => AppSizesManager.p8;

  double _getItemWidth(BuildContext context, double spacing) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = padding.left + padding.right;
    final totalSpacing = spacing * (maxItemsPerRow - 1);
    return (screenWidth - horizontalPadding - totalSpacing) / maxItemsPerRow;
  }
}
