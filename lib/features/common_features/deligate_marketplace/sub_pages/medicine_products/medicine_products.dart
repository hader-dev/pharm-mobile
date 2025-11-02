import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_3.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/sub_pages/medicine_products/widget/filters_bar.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/responsive/silver_grid_params.dart';

import 'cubit/medicine_products_cubit.dart';

class MedicineProductsPage extends StatefulWidget {
  const MedicineProductsPage({super.key});

  @override
  State<MedicineProductsPage> createState() => _MedicineProductsPageState();
}

class _MedicineProductsPageState extends State<MedicineProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MedicineProductsCubit>(context);

    super.build(context);
    return Scaffold(
      body: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
            child: Column(
              children: [
                const FiltersBar(),
                Expanded(
                  child: Builder(builder: (context) {
                    final medicines = state.medicines;
                    if (state is MedicineProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is MedicineProductsLoadingFailed ||
                        medicines.isEmpty) {
                      return const Center(child: EmptyListWidget());
                    }

                    final bool isLoadingMore = state is MedicineProductsLoading;
                    final bool hasReachedEnd =
                        state is MedicinesLoadLimitReached;

                    void onLikeTapped(BaseMedicineCatalogModel medicine) {
                      final id = medicine.id;
                      final gCubit = DeligateMarketPlaceScreen
                          .marketPlaceScaffoldKey.currentContext!
                          .read<MedicineProductsCubit>();
                      final hCubit = HomeScreen.scaffoldKey.currentContext!
                          .read<MedicineProductsCubit>();
                      medicine.isLiked
                          ? cubit.unlikeMedicinesCatalog(id)
                          : cubit.likeMedicinesCatalog(id);

                      gCubit.refreshMedicineCatalogFavorite(
                          id, !medicine.isLiked);
                      hCubit.refreshMedicineCatalogFavorite(
                          id, !medicine.isLiked);
                    }

                    return RefreshIndicator(
                      onRefresh: () => cubit.getMedicines(),
                      child: GridView.builder(
                        controller: cubit.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: calculateMarketplaceCrossAxisCount(
                              context.deviceSize),
                          crossAxisSpacing: calculateMarketplaceGridSpacing(
                              context.deviceSize),
                          mainAxisSpacing: calculateMarketplaceMainAxisSpacing(
                              context.deviceSize),
                          childAspectRatio: calculateMarketplaceAspectRatio(
                              context.deviceSize, context.orientation),
                        ),
                        itemCount: medicines.length +
                            (isLoadingMore || hasReachedEnd ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < medicines.length) {
                            final medicine = medicines[index];
                            return MedicineWidget3(
                              medicineData: medicine,
                              onFavoriteCallback: onLikeTapped,
                              route:
                                  RoutingManager.deligateMedicineDetailsScreen,
                            );
                          } else {
                            if (isLoadingMore) {
                              return Padding(
                                padding: EdgeInsets.all(
                                    context.responsiveAppSizeTheme.current.s16),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else if (hasReachedEnd) {
                              return const EndOfLoadResultWidget();
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    );
                  }),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
