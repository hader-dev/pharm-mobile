import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_2.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../common/shimmers/vertical_product_widget_shimmer.dart' show VerticalProductWidgetShimmer;

class ParaPharmaSectionItems extends StatelessWidget {
  final double minSectionHeight;
  const ParaPharmaSectionItems({super.key, required this.minSectionHeight});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
      builder: (context, state) {
        ParaPharmaCubit paraPharmaProductsCubit = context.read<ParaPharmaCubit>();
        final items = state.paraPharmaProducts;

        if (state is ParaPharmaProductsLoading) {
          return AspectRatio(
              aspectRatio: context.isTabelet ? 2 : 1.2,
              child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 0),
                  children: List.generate(
                    4,
                    (_) => SizedBox(
                      width: screenWidth > 768 ? 300 : 250,
                      height: minSectionHeight,
                      child: VerticalProductWidgetShimmer(),
                    ),
                  )));
        }

        if (state is ParaPharmaProductsLoadingFailed || items.isEmpty) {
          return Center(
            child: EmptyListWidget(),
          );
        }
        void onFavoriteCallback(BaseParaPharmaCatalogModel medicine) {
          final gCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!.read<ParaPharmaCubit>();
          final hCubit = HomeScreen.scaffoldKey.currentContext?.read<ParaPharmaCubit>();
          medicine.isLiked
              ? paraPharmaProductsCubit.unlikeParaPharmaCatalog(medicine.id)
              : paraPharmaProductsCubit.likeParaPharmaCatalog(medicine.id);

          gCubit.refreshParaPharmaCatalogFavorite(medicine.id, !medicine.isLiked);
          hCubit?.refreshParaPharmaCatalogFavorite(medicine.id, !medicine.isLiked);
        }

        return AspectRatio(
          aspectRatio: context.isTabelet ? 2 : 1.2,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: screenWidth > 768 ? 300 : 250,
                child: ParaPharmaWidget2(paraPharmData: items[index], onFavoriteCallback: onFavoriteCallback),
              );
            },
          ),
        );
      },
    );
  }
}
