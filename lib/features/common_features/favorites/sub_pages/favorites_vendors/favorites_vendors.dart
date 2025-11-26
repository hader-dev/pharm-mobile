import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/shimmers/vendor_widget_shimmer_2.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';

import 'package:hader_pharm_mobile/features/common_features/favorites/cubit/favorites_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/sub_pages/favorites_vendors/widget/vendor_item.dart'
    show VendorItem;

class FavoritesVendors extends StatelessWidget {
  const FavoritesVendors({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoritesCubit>();

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (previous, current) {
        if (current is FavoritesVendorsLoaded ||
            current is FavoritesVendorsLoadingFailed ||
            current is FavoritesVendorsLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is FavoritesVendorsLoading) {
          return ListView(
              shrinkWrap: true,
              children: List.generate(
                4,
                (_) => VendorWidgetShimmer2(),
              ));
        }

        if (state.likedVendors.isEmpty) {
          return EmptyListWidget(
            onRefresh: cubit.fetchLikedVendors,
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: cubit.fetchLikedVendors,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.likedVendors.length,
                  itemBuilder: (_, index) {
                    return VendorItem(
                      companyData: state.likedVendors[index],
                      hideLikeButton: true,
                      hideRemoveButton: false,
                      isLiked: true,
                      onRemoveFromFavorites: () => cubit.unlikeVendor(state.likedVendors[index].id),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
