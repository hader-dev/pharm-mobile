import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/buttons/search_filter_button.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_horizontal.dart';
import 'package:hader_pharm_mobile/features/common/widgets/search_bar_with_filter.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/pages/para_medical_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/vendor_details/cubit/providers.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ParapharmaPage extends StatefulWidget {
  const ParapharmaPage({super.key});

  @override
  State<ParapharmaPage> createState() => _ParapharmaPageState();
}

class _ParapharmaPageState extends State<ParapharmaPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final parapharmCubit = context.read<ParaPharmaCubit>();
    final filterCubit = context.read<ParaMedicalFiltersCubit>();

    final state = parapharmCubit.state;

    return Material(
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SearchWithFilterBarWidget(
                onChanged: (searchValue) {
                  parapharmCubit.searchParaPharmaCatalog(searchValue);
                },
                onFilterTap: () {
                  state.searchController.clear();
                  parapharmCubit.searchParaPharmaCatalog(null);
                },
                hintText: context.translation!.search_by_dci_brand_sku,
                searchController: state.searchController,
              ),
            ),
            // BlocBuilder<ParaPharmaCubit, ParaPharmaState>(builder: (context, state) {
            //   return SearchFilterButton(
            //       hasActiveFilters: state.hasActiveFilters,
            //       onTap: () {
            //         BottomSheetHelper.showCommonBottomSheet(
            //           context: context,
            //           child: ParaPharmFilterProvider(
            //             parapharmCubit: parapharmCubit,
            //             filterCubit: filterCubit,
            //             child: ParaMedicalFiltersView(),
            //           ),
            //         );
            //       });
            // }),
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
                return EmptyListWidget(
                  onRefresh: () {
                    parapharmCubit.getParaPharmas();
                  },
                );
              }

              final bool isLoadingMore = state is LoadingMoreParaPharma;
              final bool hasReachedEnd = state is ParaPharmasLoadLimitReached;

              void onLikeTapped(BaseParaPharmaCatalogModel paraPharma) {
                final id = paraPharma.id;
                paraPharma.isLiked
                    ? BlocProvider.of<ParaPharmaCubit>(bContext).unlikeParaPharmaCatalog(id)
                    : BlocProvider.of<ParaPharmaCubit>(bContext).likeParaPharmaCatalog(id);
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return parapharmCubit.getParaPharmas();
                      },
                      child: ListView.builder(
                        controller: state.scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: paraPharmaProducts.length + (isLoadingMore || hasReachedEnd ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < paraPharmaProducts.length) {
                            final paraPharma = paraPharmaProducts[index];
                            return ParaPharmaWidgetHorizantal(
                              paraPharmData: paraPharma,
                              onFavoriteCallback: onLikeTapped,
                              isLiked: paraPharma.isLiked,
                            );
                          } else {
                            if (isLoadingMore) {
                              return Padding(
                                padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.s16),
                                child: Center(child: CircularProgressIndicator()),
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
                  if (state is LoadingMoreParaPharma) const Center(child: CircularProgressIndicator()),
                  if (state is ParaPharmasLoadLimitReached) const EndOfLoadResultWidget(),
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
