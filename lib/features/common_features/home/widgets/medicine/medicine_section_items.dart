import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_3.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common/shimmers/vertical_product_widget_shimmer.dart'
    show VerticalProductWidgetShimmer;
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class MedicinesSectionItems extends StatelessWidget {
  const MedicinesSectionItems({super.key, required this.minSectionHeight});
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
      builder: (context, state) {
        final items = state.medicines;

        if (state is MedicineProductsLoading) {
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

        if (state is MedicineProductsLoadingFailed || items.isEmpty) {
          return Center(
            child: EmptyListWidget(),
          );
        }
        void onFavoriteCallback(BaseMedicineCatalogModel medicine) {
          final cubit = context.read<MedicineProductsCubit>();
          final gCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!.read<MedicineProductsCubit>();
          final hCubit = HomeScreen.scaffoldKey.currentContext!.read<MedicineProductsCubit>();

          medicine.isLiked ? cubit.unlikeMedicinesCatalog(medicine.id) : cubit.likeMedicinesCatalog(medicine.id);

          gCubit.refreshMedicineCatalogFavorite(medicine.id, !medicine.isLiked);
          hCubit.refreshMedicineCatalogFavorite(medicine.id, !medicine.isLiked);
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
                child: MedicineWidget3(
                  medicineData: items[index],
                  onFavoriteCallback: onFavoriteCallback,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
