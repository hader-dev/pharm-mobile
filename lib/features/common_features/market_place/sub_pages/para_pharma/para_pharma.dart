import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/shimmers/horizontal_product_widget_shimmer.dart'
    show HorizontalProductWidgetShimmer;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_1.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/quick_add_modal.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'cubit/para_pharma_cubit.dart';
import 'widget/filters_bar_v2.dart' show FiltersBarV2;

class ParaPharmaProductsPage extends StatefulWidget {
  const ParaPharmaProductsPage({super.key});

  @override
  State<ParaPharmaProductsPage> createState() => ParaPharmaProductsPageState();
}

class ParaPharmaProductsPageState extends State<ParaPharmaProductsPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late final Animation animation;
  static late AnimationController animationController;
  @override
  initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 5));
    animation =
        Tween<double>(begin: 1, end: 0).animate(animationController.drive(CurveTween(curve: Curves.easeInCubic)));
  }

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
            AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return AnimatedOpacity(
                      opacity: (animation.value == 1) ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: (animation.value == 0) ? SizedBox.shrink() : child!);
                },
                child: FiltersBarV2()),
            Expanded(
              child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
                builder: (context, state) {
                  final gCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!.read<ParaPharmaCubit>();
                  final hCubit = HomeScreen.scaffoldKey.currentContext?.read<ParaPharmaCubit>();

                  final bool isLoadingMore = state is LoadingMoreParaPharma;
                  final bool hasReachedEnd = state is ParaPharmasLoadLimitReached;

                  void onLikeTapped(BaseParaPharmaCatalogModel parapharmProduct) {
                    final id = parapharmProduct.id;
                    parapharmProduct.isLiked ? cubit.unlikeParaPharmaCatalog(id) : cubit.likeParaPharmaCatalog(id);
                    gCubit.refreshParaPharmaCatalogFavorite(id, !parapharmProduct.isLiked);
                    hCubit?.refreshParaPharmaCatalogFavorite(id, !parapharmProduct.isLiked);
                  }

                  void onQuickAddCallback(BaseParaPharmaCatalogModel parapharmProduct) {
                    BottomSheetHelper.showCommonBottomSheet(
                        initialChildSize: .5,
                        context: context,
                        child: QuickCartAddModal(
                          paraPharmaCatalogId: parapharmProduct.id,
                          maxOrderQuantity: parapharmProduct.maxOrderQuantity,
                          minOrderQuantity: parapharmProduct.minOrderQuantity,
                        ));
                  }

                  if (state is ParaPharmaProductsLoading) {
                    return ListView(
                        shrinkWrap: true,
                        children: List.generate(
                          4,
                          (_) => HorizontalProductWidgetShimmer(),
                        ));
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
                          ...state.paraPharmaProducts.map((paraPharma) => ParaPharmaWidget1(
                                paraPharmData: paraPharma,
                                onFavoriteCallback: onLikeTapped,
                                onQuickAddCallback: onQuickAddCallback,
                                isLiked: paraPharma.isLiked,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
