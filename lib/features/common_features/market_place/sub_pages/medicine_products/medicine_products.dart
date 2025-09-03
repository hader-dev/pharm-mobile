import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_3.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/filters_bar.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
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
    super.build(context);
    return RefreshIndicator(
      onRefresh: () => context.read<MedicineProductsCubit>().getMedicines(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppSizesManager.p8),
          child: Column(
            children: [
              FiltersBar(),
              Expanded(
                child:
                    BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
                  builder: (context, state) {
                    final cubit =
                        BlocProvider.of<MedicineProductsCubit>(context);
                    final medicines = cubit.medicines;
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
                      medicine.isLiked
                          ? cubit.unlikeMedicinesCatalog(id)
                          : cubit.likeMedicinesCatalog(id);
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
                            );
                          } else {
                            if (isLoadingMore) {
                              return const Padding(
                                padding: EdgeInsets.all(AppSizesManager.s16),
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
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
