import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_2.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/widget/floating_filter.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'cubit/para_pharma_cubit.dart';

class ParaPharmaSearchFilterBottomSheet extends StatefulWidget {
  const ParaPharmaSearchFilterBottomSheet({super.key});

  @override
  State<ParaPharmaSearchFilterBottomSheet> createState() =>
      _ParaPharmaSearchFilterBottomSheetState();
}

class _ParaPharmaSearchFilterBottomSheetState
    extends State<ParaPharmaSearchFilterBottomSheet>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
              builder: (context, state) {
                final cubit = BlocProvider.of<ParaPharmaCubit>(context);
                final products = cubit.paraPharmaProducts;

                if (state is ParaPharmaProductsLoadingFailed) {
                  return const Center(child: EmptyListWidget());
                }
                if (state is ParaPharmaProductsLoading && products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ParaPharmaProductsLoaded && products.isEmpty) {
                  return const Center(child: EmptyListWidget());
                }

                final bool isLoadingMore = state is LoadingMoreParaPharma;
                final bool hasReachedEnd = state is ParaPharmasLoadLimitReached;

                void onLikeTapped(BaseParaPharmaCatalogModel medicine) {
                  final id = medicine.id;
                  medicine.isLiked
                      ? cubit.unlikeParaPharmaCatalog(id)
                      : cubit.likeParaPharmaCatalog(id);
                }

                return RefreshIndicator(
                  onRefresh: () => cubit.getParaPharmas(),
                  child: GridView.builder(
                    controller: cubit.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.marketplaceCrossAxisCount,
                      crossAxisSpacing: context.marketplaceGridSpacing,
                      mainAxisSpacing: context.marketplaceMainAxisSpacing,
                      childAspectRatio: context.marketplaceAspectRatio,
                    ),
                    itemCount: products.length +
                        (isLoadingMore || hasReachedEnd ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        final paraPharma = products[index];
                        return ParaPharmaWidget2(
                            paraPharmData: paraPharma,
                            onFavoriteCallback: onLikeTapped);
                      } else {
                        if (isLoadingMore) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
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
          ),
        ],
      ),
      floatingActionButton: FloatingFilterParaMedical(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
