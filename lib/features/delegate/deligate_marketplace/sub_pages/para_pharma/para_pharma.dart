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

    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FiltersBar(),
          Expanded(
            child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
              builder: (context, state) {
                final bool isLoadingMore = state is LoadingMoreParaPharma;
                final bool hasReachedEnd = state is ParaPharmasLoadLimitReached;

                void onQuickAddTapped(BaseParaPharmaCatalogModel product) {
                  BottomSheetHelper.showCommonBottomSheet(
                    context: context,
                    child: AddCartBottomSheetManual(
                      deligateCreateOrderCubit: DeligateMarketPlaceScreen.marketPlaceScaffoldKey.currentContext
                          ?.read<DeligateCreateOrderCubit>(),
                      product: product,
                      buyerCompanyId: cubit.buyerCompanyId,
                    ),
                  );
                }

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

                if (state is ParaPharmaProductsLoaded && state.paraPharmaProducts.isEmpty) {
                  return Center(
                      child: EmptyListWidget(
                    onRefresh: () => cubit.getParaPharmas(),
                  ));
                }

                return RefreshIndicator(
                  onRefresh: () => cubit.getParaPharmas(),
                  child: Scrollbar(
                    controller: state.scrollController,
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: state.scrollController,
                      children: [
                        ...state.paraPharmaProducts.map((paraPharma) => ParaPharmaWidgetHorizantal(
                              paraPharmData: paraPharma,
                              onQuickAddCallback: onQuickAddTapped,
                              isLiked: paraPharma.isLiked,
                              route: RoutingManager.deligateParapharmDetailsScreen,
                              buyerCompanyId: cubit.buyerCompanyId,
                              canOrder: true,
                            )),
                        if (isLoadingMore)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator())),
                          ),
                        if (hasReachedEnd) const EndOfLoadResultWidget()
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
