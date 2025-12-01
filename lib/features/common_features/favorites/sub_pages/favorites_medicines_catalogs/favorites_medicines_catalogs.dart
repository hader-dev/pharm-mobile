import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_2.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/cubit/favorites_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';

import '../../../../common/shimmers/horizontal_product_widget_shimmer.dart' show HorizontalProductWidgetShimmer;

class FavoritesMedicinesCatalog extends StatelessWidget {
  const FavoritesMedicinesCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final gCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext?.read<MedicineProductsCubit?>();
    final hCubit = HomeScreen.scaffoldKey.currentContext?.read<MedicineProductsCubit?>();
    final cubit = context.read<FavoritesCubit>();

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (previous, current) {
        if (current is FavoritesMedicinesLoaded ||
            current is FavoritesMedicinesLoadingFailed ||
            current is FavoritesMedicinesLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is FavoritesMedicinesLoading) {
          return ListView(
              shrinkWrap: true,
              children: List.generate(
                4,
                (_) => HorizontalProductWidgetShimmer(),
              ));
        }
        if (state.likedMedicinesCatalogs.isEmpty) {
          return EmptyListWidget(
            onRefresh: cubit.fetchLikedMedicines,
          );
        }
        return RefreshIndicator(
          onRefresh: cubit.fetchLikedMedicines,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.likedMedicinesCatalogs.length,
            itemBuilder: (context, index) => SizedBox(
              height: 150,
              child: MedicineWidget2(
                hideLikeButton: false,
                onRemoveFromFavorites: () {
                  final id = state.likedMedicinesCatalogs[index].id;
                  cubit.unlikeMedicine(id);
                  gCubit?.refreshMedicineCatalogFavorite(id, false);
                  hCubit?.refreshMedicineCatalogFavorite(id, false);
                },
                medicineData: state.likedMedicinesCatalogs[index],
                isLiked: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
