import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/cubit/favorites_cubit.dart';

import '../../../../common/widgets/empty_list.dart';
import '../../../../common/widgets/medicine_widget_2.dart';

class FavoritesMedicinesCatalog extends StatelessWidget {
  const FavoritesMedicinesCatalog({super.key});

  @override
  Widget build(BuildContext context) {
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
          return const Center(child: CircularProgressIndicator());
        }
        if (BlocProvider.of<FavoritesCubit>(context)
            .likedMedicinesCatalogs
            .isEmpty) {
          return EmptyListWidget();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return BlocProvider.of<FavoritesCubit>(context)
                      .fetchLikedMedicines();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: BlocProvider.of<FavoritesCubit>(context)
                      .likedMedicinesCatalogs
                      .length,
                  itemBuilder: (context, index) => MedicineWidget2(
                    hideRemoveButton: false,
                    onRemoveFromFavorites: () =>
                        BlocProvider.of<FavoritesCubit>(context).unlikeMedicine(
                            BlocProvider.of<FavoritesCubit>(context)
                                .likedMedicinesCatalogs[index]
                                .id),
                    medicineData: BlocProvider.of<FavoritesCubit>(context)
                        .likedMedicinesCatalogs[index],
                    isLiked: true,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
