import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_horizontal.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/cubit/favorites_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

import '../../../../common/shimmers/horizontal_product_widget_shimmer.dart' show HorizontalProductWidgetShimmer;

class FavoritesParaPharmaCatalogs extends StatelessWidget {
  const FavoritesParaPharmaCatalogs({super.key});

  @override
  Widget build(BuildContext context) {
    final gCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext?.read<ParaPharmaCubit>();
    final hCubit = HomeScreen.scaffoldKey.currentContext?.read<ParaPharmaCubit>();
    final cubit = context.read<FavoritesCubit>();

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (previous, current) {
        if (current is FavoritesParaPharmaLoaded ||
            current is FavoritesParaPharmaLoadingFailed ||
            current is FavoritesParaPharmaLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is FavoritesParaPharmaLoading) {
          return ListView(
              shrinkWrap: true,
              children: List.generate(
                4,
                (_) => HorizontalProductWidgetShimmer(),
              ));
        }
        if (state.likedParaPharmaCatalogs.isEmpty) {
          return EmptyListWidget(
            onRefresh: cubit.fetchLikedParaPharma,
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.fetchLikedParaPharma,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.likedParaPharmaCatalogs.length,
              itemBuilder: (context, index) {
                void onLikeTapped(BaseParaPharmaCatalogModel medicine) {
                  final id = medicine.id;
                  cubit.unlikeParaPharma(id);
                  gCubit?.refreshParaPharmaCatalogFavorite(id, false);
                  hCubit?.refreshParaPharmaCatalogFavorite(id, false);
                }

                return ParaPharmaWidgetHorizantal(
                  isLiked: true,
                  onFavoriteCallback: onLikeTapped,
                  paraPharmData: state.likedParaPharmaCatalogs[index],
                );
              }),
        );
      },
    );
  }
}
