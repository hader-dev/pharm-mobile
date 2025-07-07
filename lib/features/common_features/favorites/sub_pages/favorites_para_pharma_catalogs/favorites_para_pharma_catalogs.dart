import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_1.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/cubit/favorites_cubit.dart';

import '../../../../common/widgets/empty_list.dart';

class FavoritesParaPharmaCatalogs extends StatelessWidget {
  const FavoritesParaPharmaCatalogs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesParaPharmaLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FavoritesParaPharmaLoaded &&
            BlocProvider.of<FavoritesCubit>(context).likedParaPharmaCatalogs.isEmpty) {
          return EmptyListWidget();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return BlocProvider.of<FavoritesCubit>(context).fetchLikedMedicines();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: BlocProvider.of<FavoritesCubit>(context).likedParaPharmaCatalogs.length,
                  itemBuilder: (context, index) => ParaPharmaWidget1(
                    isLiked: true,
                    paraPharmData: BlocProvider.of<FavoritesCubit>(context).likedParaPharmaCatalogs[index],
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
