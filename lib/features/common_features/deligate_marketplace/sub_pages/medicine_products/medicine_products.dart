import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_horizental.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/sub_pages/medicine_products/widget/filters_bar.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/add_cart_bottom_sheet_manual.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

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
    final cubit = BlocProvider.of<MedicineProductsCubit>(context);

    super.build(context);
    return BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
          child: Column(
            children: [
              const FiltersBar(),
              Expanded(
                child: Builder(builder: (context) {
                  final medicines = state.medicines;
                  if (state is MedicineProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is MedicineProductsLoadingFailed ||
                      medicines.isEmpty) {
                    return const Center(child: EmptyListWidget());
                  }

                  if (state is MedicineProductsLoaded && medicines.isEmpty) {
                    return Center(
                        child: EmptyListWidget(
                      onRefresh: () => cubit.getMedicines(),
                    ));
                  }

                  final bool isLoadingMore = state is MedicineProductsLoading;
                  final bool hasReachedEnd = state is MedicinesLoadLimitReached;

                  void onQuickAddTapped(BaseMedicineCatalogModel product) {
                    BottomSheetHelper.showCommonBottomSheet(
                      context: context,
                      child: AddCartBottomSheetManual(
                        deligateCreateOrderCubit: DeligateMarketPlaceScreen
                            .marketPlaceScaffoldKey.currentContext
                            ?.read<DeligateCreateOrderCubit>(),
                        product: product,
                        buyerCompanyId: cubit.buyerCompanyId,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => cubit.getMedicines(),
                    child: Scrollbar(
                      controller: cubit.scrollController,
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: cubit.scrollController,
                        children: [
                          ...state.medicines
                              .map((medicine) => MedicineWidgetHorizontal(
                                    medicineData: medicine,
                                    isLiked: medicine.isLiked,
                                    onQuickAddCallback: onQuickAddTapped,
                                    route: RoutingManager
                                        .deligateMedicineDetailsScreen,
                                    buyerCompanyId: cubit.buyerCompanyId,
                                    hideLikeButton: false,
                                  )),
                          if (isLoadingMore)
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator())),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
