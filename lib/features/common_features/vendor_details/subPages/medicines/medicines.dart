import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/buttons/search_filter_button.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_2.dart';
import 'package:hader_pharm_mobile/features/common/widgets/search_bar_with_filter.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/responsive/silver_grid_params.dart';

class MedicinesPage extends StatefulWidget {
  const MedicinesPage({super.key});

  @override
  State<MedicinesPage> createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<MedicineProductsCubit>();

    return Material(
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SearchWithFilterBarWidget(
                onChanged: (searchValue) {
                  cubit.searchMedicineCatalog(searchValue);
                },
                onFilterTap: () {
                  cubit.state.searchController.clear();
                  cubit.searchMedicineCatalog(null);
                },
                hintText: context.translation!.search_by_dci_brand_sku,
                searchController: cubit.state.searchController,
              ),
            ),
            BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
                builder: (context, state) {
              return SearchFilterButton(
                hasActiveFilters: state.hasActiveFilters,
                onTap: () {
                  BottomSheetHelper.showCommonBottomSheet(
                      context: context,
                      child: SearchMedicineFilterBottomSheet());
                },
              );
            }),
          ],
        ),
        Expanded(
          child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
            builder: (bContext, state) {
              if (state is MedicineLiked || state is MedicineLikeFailed) {}
              if (state is MedicineProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.medicines.isEmpty) {
                return EmptyListWidget();
              }

              void onLikeTapped(BaseMedicineCatalogModel paraPharma) {
                final id = paraPharma.id;
                paraPharma.isLiked
                    ? BlocProvider.of<MedicineProductsCubit>(bContext)
                        .unlikeMedicinesCatalog(id)
                    : BlocProvider.of<MedicineProductsCubit>(bContext)
                        .likeMedicinesCatalog(id);
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return cubit.getMedicines();
                      },
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: calculateMarketplaceCrossAxisCount(
                              bContext.deviceSize),
                          crossAxisSpacing: calculateMarketplaceGridSpacing(
                              bContext.deviceSize),
                          mainAxisSpacing: calculateMarketplaceMainAxisSpacing(
                              bContext.deviceSize),
                          childAspectRatio: calculateVendorItemsAspectRatio(
                              bContext.deviceSize, bContext.orientation),
                        ),
                        controller: cubit.scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.medicines.length,
                        itemBuilder: (context, index) => MedicineWidget2(
                          medicineData: state.medicines[index],
                          isLiked: state.medicines[index].isLiked,
                          hideLikeButton: false,
                          onLikeTapped: () =>
                              onLikeTapped(state.medicines[index]),
                        ),
                      ),
                    ),
                  ),
                  if (state is LoadingMoreMedicine)
                    const Center(child: CircularProgressIndicator()),
                  if (state is MedicinesLoadLimitReached)
                    EndOfLoadResultWidget(),
                ],
              );
            },
          ),
        ),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
