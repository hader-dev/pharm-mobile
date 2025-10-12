import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/vendor_item.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/cubit/favorites_cubit.dart';

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
          return const Center(child: CircularProgressIndicator());
        }
        if (cubit.likedVendors.isEmpty) {
          return EmptyListWidget();
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
                  itemCount: BlocProvider.of<FavoritesCubit>(context)
                      .likedVendors
                      .length,
                  itemBuilder: (_, index) {
                    return VendorItem(
                        companyData: BlocProvider.of<FavoritesCubit>(context)
                            .likedVendors[index],
                        hideRemoveButton: false,
                        onRemoveFromFavorites: () {
                          final id = cubit.likedVendors[index].id;
                          cubit.unlikeVendor(id);
                        });
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
