// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_2.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_products/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/widget/filters_bar.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/responsive/silver_grid_params.dart';

class DeligateProductsScreen extends StatelessWidget {
  const DeligateProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ParapharmaStateProvider(child: DeligateProductsPage());
  }
}

class DeligateProductsPage extends StatefulWidget {
  const DeligateProductsPage({super.key});

  @override
  State<DeligateProductsPage> createState() => _DeligateProductsPageState();
}

class _DeligateProductsPageState extends State<DeligateProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ParaPharmaCubit>(context);

    return Scaffold(
      key: MarketPlaceScreen.marketPlaceScaffoldKey,
      appBar: DeligateProductsAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizesManager.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FiltersBar(),
            Expanded(
              child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
                buildWhen: (prev, curr) =>
                    prev.paraPharmaProducts.length !=
                    curr.paraPharmaProducts.length,
                builder: (bcontext, state) {
                  final products = state.paraPharmaProducts;

                  final bool isLoadingMore = state is LoadingMoreParaPharma;
                  final bool hasReachedEnd =
                      state is ParaPharmasLoadLimitReached;

                  void onLikeTapped(BaseParaPharmaCatalogModel medicine) {
                    final id = medicine.id;
                    medicine.isLiked
                        ? cubit.unlikeParaPharmaCatalog(id)
                        : cubit.likeParaPharmaCatalog(id);
                  }

                  return RefreshIndicator(
                    onRefresh: () => cubit.getParaPharmas(),
                    child: (state is ParaPharmaProductsLoadingFailed ||
                            products.isEmpty)
                        ? LayoutBuilder(
                            builder: (context, constraints) {
                              return SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: SizedBox(
                                  height: constraints.maxHeight,
                                  child: const Center(child: EmptyListWidget()),
                                ),
                              );
                            },
                          )
                        : GridView.builder(
                            controller: cubit.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  calculateMarketplaceCrossAxisCount(
                                      context.deviceSize),
                              crossAxisSpacing: calculateMarketplaceGridSpacing(
                                  context.deviceSize),
                              mainAxisSpacing:
                                  calculateMarketplaceMainAxisSpacing(
                                      context.deviceSize),
                              childAspectRatio: calculateMarketplaceAspectRatio(
                                  context.deviceSize, context.orientation),
                            ),
                            itemCount: products.length +
                                (isLoadingMore || hasReachedEnd ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < products.length) {
                                final paraPharma = products[index];
                                return ParaPharmaWidget2(
                                    paraPharmData: paraPharma,
                                    displayTags: false,
                                    canOrder: false,
                                    showQuickAddButton: false,
                                    onFavoriteCallback: onLikeTapped);
                              } else {
                                if (isLoadingMore) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                        child: CircularProgressIndicator()),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
