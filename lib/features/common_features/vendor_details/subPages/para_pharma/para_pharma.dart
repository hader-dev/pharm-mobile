import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/buttons/search_filter_button.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_2.dart';
import 'package:hader_pharm_mobile/features/common/widgets/search_bar_with_filter.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/pages/para_medical_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/responsive/silver_grid_params.dart';

class ParapharmaPage extends StatefulWidget {
  const ParapharmaPage({super.key});

  @override
  State<ParapharmaPage> createState() => _ParapharmaPageState();
}

class _ParapharmaPageState extends State<ParapharmaPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<ParaPharmaCubit>();
    final state = cubit.state;

    return Material(
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SearchWithFilterBarWidget(
                onChanged: (searchValue) {
                  cubit.searchParaPharmaCatalog(searchValue);
                },
                onFilterTap: () {
                  state.searchController.clear();
                  cubit.searchParaPharmaCatalog(null);
                },
                hintText: context.translation!.search_by_dci_brand_sku,
                searchController: state.searchController,
              ),
            ),
            BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
                builder: (context, state) {
              return SearchFilterButton(
                  hasActiveFilters: state.hasActiveFilters,
                  onTap: () {
                    BottomSheetHelper.showCommonBottomSheet(
                      context: context,
                      child: ParaPharmFilterProvider(
                          child: ParaMedicalFiltersView()),
                    );
                  });
            }),
          ],
        ),
        Expanded(
          child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
            builder: (bContext, state) {
              if (state is ParaPharmaProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final paraPharmaProducts = state.paraPharmaProducts;

              if (paraPharmaProducts.isEmpty) {
                return EmptyListWidget();
              }

              final bool isLoadingMore = state is LoadingMoreParaPharma;
              final bool hasReachedEnd = state is ParaPharmasLoadLimitReached;

              void onLikeTapped(BaseParaPharmaCatalogModel paraPharma) {
                final id = paraPharma.id;
                paraPharma.isLiked
                    ? BlocProvider.of<ParaPharmaCubit>(bContext)
                        .unlikeParaPharmaCatalog(id)
                    : BlocProvider.of<ParaPharmaCubit>(bContext)
                        .likeParaPharmaCatalog(id);
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return cubit.getParaPharmas();
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
                        controller: state.scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: paraPharmaProducts.length +
                            (isLoadingMore || hasReachedEnd ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < paraPharmaProducts.length) {
                            final paraPharma = paraPharmaProducts[index];
                            return ParaPharmaWidget2(
                              paraPharmData: paraPharma,
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
                    ),
                  ),
                  if (state is LoadingMoreMedicine)
                    const Center(child: CircularProgressIndicator()),
                  if (state is ParaPharmasLoadLimitReached)
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
