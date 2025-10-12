import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_1.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/cubit/favorites_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

class FavoritesParaPharmaCatalogs extends StatelessWidget {
  const FavoritesParaPharmaCatalogs({super.key});

  @override
  Widget build(BuildContext context) {
    final gCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
        .read<ParaPharmaCubit>();
    final hCubit =
        HomeScreen.scaffoldKey.currentContext?.read<ParaPharmaCubit>();
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
          return const Center(child: CircularProgressIndicator());
        }
        if (cubit.likedParaPharmaCatalogs.isEmpty) {
          return EmptyListWidget();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return cubit.fetchLikedParaPharma();
                },
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: cubit.likedParaPharmaCatalogs.length,
                    itemBuilder: (context, index) {
                      void onLikeTapped(BaseParaPharmaCatalogModel medicine) {
                        final id = medicine.id;
                        cubit.unlikeParaPharma(id);
                        gCubit.refreshParaPharmaCatalogFavorite(id, false);
                        hCubit?.refreshParaPharmaCatalogFavorite(id, false);
                      }

                      return ParaPharmaWidget1(
                        isLiked: true,
                        onFavoriteCallback: onLikeTapped,
                        paraPharmData: cubit.likedParaPharmaCatalogs[index],
                      );
                    }),
              ),
            ),
          ],
        );
      },
    );
  }
}
