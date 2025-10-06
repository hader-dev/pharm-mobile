import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_2.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

class ParaPharmaSectionItems extends StatelessWidget {
  const ParaPharmaSectionItems({super.key, required this.minSectionHeight});
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
      builder: (context, state) {
        ParaPharmaCubit paraPharmaProductsCubit =
            context.read<ParaPharmaCubit>();
        final items = state.paraPharmaProducts;

        if (state is ParaPharmaProductsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ParaPharmaProductsLoadingFailed || items.isEmpty) {
          return Center(
            child: EmptyListWidget(),
          );
        }
        void onFavoriteCallback(BaseParaPharmaCatalogModel medicine) {
          final gCubit = MarketPlaceScreen
              .marketPlaceScaffoldKey.currentContext!
              .read<ParaPharmaCubit>();
          final hCubit =
              HomeScreen.scaffoldKey.currentContext?.read<ParaPharmaCubit>();
          medicine.isLiked
              ? paraPharmaProductsCubit.unlikeParaPharmaCatalog(medicine.id)
              : paraPharmaProductsCubit.likeParaPharmaCatalog(medicine.id);

          gCubit.refreshParaPharmaCatalogFavorite(
              medicine.id, !medicine.isLiked);
          hCubit?.refreshParaPharmaCatalogFavorite(
              medicine.id, !medicine.isLiked);
        }

        return SizedBox(
          height: 240,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: screenWidth > 768 ? 300 : 240,
                child: ParaPharmaWidget2(
                    paraPharmData: items[index],
                    onFavoriteCallback: onFavoriteCallback),
              );
            },
          ),
        );
      },
    );
  }
}
