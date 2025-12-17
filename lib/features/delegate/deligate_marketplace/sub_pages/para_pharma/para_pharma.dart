import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_horizontal.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_marketplace/market_place.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_marketplace/sub_pages/para_pharma/widget/filters_bar.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/add_cart_bottom_sheet_manual.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/responsive/silver_grid_params.dart';

import 'cubit/para_pharma_cubit.dart';

class ParaPharmaProductsPage extends StatefulWidget {
  const ParaPharmaProductsPage({super.key});

  @override
  State<ParaPharmaProductsPage> createState() => _ParaPharmaProductsPageState();
}

class _ParaPharmaProductsPageState extends State<ParaPharmaProductsPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ParaPharmaCubit>(context);

    super.build(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FiltersBar(),
            Expanded(
              child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
                builder: (context, state) {
                  final products = state.paraPharmaProducts;

                  final bool isLoadingMore = state is LoadingMoreParaPharma;
                  final bool hasReachedEnd = state is ParaPharmasLoadLimitReached;

                  void onQuickAddTapped(BaseParaPharmaCatalogModel product) {
                    BottomSheetHelper.showCommonBottomSheet(
                      context: context,
                      child: AddCartBottomSheetManual(
                        deligateCreateOrderCubit: DeligateMarketPlaceScreen.marketPlaceScaffoldKey.currentContext
                            ?.read<DelegateCreateOrderCubit>(),
                        product: product,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => cubit.getParaPharmas(),
                    child: (state is ParaPharmaProductsLoadingFailed || products.isEmpty)
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
                            controller: state.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: calculateMarketplaceCrossAxisCount(context.deviceSize),
                              crossAxisSpacing: calculateMarketplaceGridSpacing(context.deviceSize),
                              mainAxisSpacing: calculateMarketplaceMainAxisSpacing(context.deviceSize),
                              childAspectRatio:
                                  calculateMarketplaceAspectRatio(context.deviceSize, context.orientation),
                            ),
                            itemCount: products.length + (isLoadingMore || hasReachedEnd ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < products.length) {
                                final paraPharma = products[index];
                                return ParaPharmaWidgetHorizantal(
                                  paraPharmData: paraPharma,
                                  onQuickAddCallback: onQuickAddTapped,
                                  isLiked: paraPharma.isLiked,
                                  route: RoutingManager.deligateParapharmDetailsScreen,
                                  canOrder: true,
                                );
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
