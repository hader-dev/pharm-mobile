import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_2.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/filters_bar_v2.dart'
    show FiltersBarV2;
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/quick_add_modal.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../common/shimmers/horizontal_product_widget_shimmer.dart' show HorizontalProductWidgetShimmer;
import 'cubit/medicine_products_cubit.dart';

class MedicineProductsPage extends StatefulWidget {
  const MedicineProductsPage({super.key});

  @override
  State<MedicineProductsPage> createState() => MedicineProductsPageState();
}

class MedicineProductsPageState extends State<MedicineProductsPage>
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
    final cubit = BlocProvider.of<MedicineProductsCubit>(context);

    super.build(context);
    return Scaffold(
      body: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
            child: Column(
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
                  child: Builder(builder: (context) {
                    final medicines = state.medicines;

                    final bool isLoadingMore = state is MedicineProductsLoading;
                    final bool hasReachedEnd = state is MedicinesLoadLimitReached;

                    void onLikeTapped(BaseMedicineCatalogModel medicine) {
                      final id = medicine.id;
                      final gCubit =
                          MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!.read<MedicineProductsCubit>();
                      final hCubit = HomeScreen.scaffoldKey.currentContext!.read<MedicineProductsCubit>();
                      medicine.isLiked ? cubit.unlikeMedicinesCatalog(id) : cubit.likeMedicinesCatalog(id);

                      gCubit.refreshMedicineCatalogFavorite(id, !medicine.isLiked);
                      hCubit.refreshMedicineCatalogFavorite(id, !medicine.isLiked);
                    }

                    void onQuickAddCallback(BaseMedicineCatalogModel medicineProduct) {
                      BottomSheetHelper.showCommonBottomSheet(
                          initialChildSize: .5,
                          context: context,
                          child: QuickCartAddModal(
                            medicineCatalogId: medicineProduct.id,
                            minOrderQuantity: medicineProduct.minOrderQuantity,
                            maxOrderQuantity: medicineProduct.maxOrderQuantity,
                          ));
                    }

                    if (state is MedicineProductsLoading) {
                      return ListView(
                          shrinkWrap: true,
                          children: List.generate(
                            4,
                            (_) => HorizontalProductWidgetShimmer(),
                          ));
                    }

                    if (state is MedicineProductsLoaded && medicines.isEmpty) {
                      return Center(
                          child: EmptyListWidget(
                        onRefresh: () => cubit.getMedicines(),
                      ));
                    }

                    return RefreshIndicator(
                      onRefresh: () => cubit.getMedicines(),
                      child: Scrollbar(
                        controller: state.scrollController,
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: state.scrollController,
                          children: [
                            ...state.medicines.map((medicine) => MedicineWidget2(
                                  medicineData: medicine,
                                  isLiked: medicine.isLiked,
                                  onLikeTapped: () => onLikeTapped(medicine),
                                  onQuickAddCallback: onQuickAddCallback,
                                  hideLikeButton: false,
                                )),
                            if (isLoadingMore)
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child:
                                    Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator())),
                              ),
                            if (hasReachedEnd) const EndOfLoadResultWidget()
                          ],
                        ),
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
