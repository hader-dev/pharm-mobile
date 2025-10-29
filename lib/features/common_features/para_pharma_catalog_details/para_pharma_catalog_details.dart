import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/setup_status_bar.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/info_row_column.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/trademark_widget.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'cubit/para_pharma_details_cubit.dart';
import 'cubit/provider.dart';
import 'widgets/para_pharma_product_photo_section.dart';

typedef QuantitySectionBuilder = Widget Function(double unitPrice);

class BaseParaPharmaCatalogDetailsScreen extends StatefulWidget {
  final String paraPharmaCatalogId;
  final bool canOrder;
  final bool disabledPackageQuanity;
  final bool needCartCubit;
  final QuantitySectionBuilder quantitySectionBuilder;
  static final GlobalKey<ScaffoldState> paraPharmaDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();

  const BaseParaPharmaCatalogDetailsScreen(
      {super.key,
      required this.paraPharmaCatalogId,
      required this.canOrder,
      required this.needCartCubit,
      required this.quantitySectionBuilder,
      this.disabledPackageQuanity = false});

  @override
  State<BaseParaPharmaCatalogDetailsScreen> createState() =>
      _BaseParaPharmaCatalogDetailsScreenState();
}

class _BaseParaPharmaCatalogDetailsScreenState
    extends State<BaseParaPharmaCatalogDetailsScreen>
    with TickerProviderStateMixin {
  double bottomNavbarHeightModifier = 1;

  @override
  void initState() {
    super.initState();
    setupStatusBar();
    bottomNavbarHeightModifier = widget.disabledPackageQuanity
        ? AppSizesManager.deafultQuantityNavbarHeightModifier
        : AppSizesManager.expendedQuantityNavbarHeightModifier;
  }

  @override
  Widget build(BuildContext context) {
    return StateProvider(
      needCartCubit: widget.needCartCubit,
      tabs: const [],
      vsync: this,
      catalogId: widget.paraPharmaCatalogId,
      child: BlocBuilder<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
        builder: (context, state) {
          if (state is ParaPharmaDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ParaPharmaDetailsLoadError) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BackButton(
                  color: AppColors.accent1Shade1,
                ),
                Expanded(child: Center(child: EmptyListWidget())),
              ],
            );
          }
          return Scaffold(
            appBar: ParaPharmaCatalogAppBar(),
            key:
                BaseParaPharmaCatalogDetailsScreen.paraPharmaDetailsScaffoldKey,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSizesManager.p16),
                      child: const ParaPharmaProductPhotoSection(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppSizesManager.p16,
                          right: AppSizesManager.p16,
                          bottom: AppSizesManager.p8),
                      child: Text(state.paraPharmaCatalogData.name,
                          style: context.responsiveTextTheme.current.headLine1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppSizesManager.p16,
                          right: AppSizesManager.p16,
                          bottom: AppSizesManager.p16),
                      child: TrademarkWidgetAlternate(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppSizesManager.p16,
                          right: AppSizesManager.p16),
                      child: Text(state.paraPharmaCatalogData.description,
                          style:
                              context.responsiveTextTheme.current.body1Regular),
                    ),
                    InfoRowColumn(
                      data: [
                        RowColumnDataHolders(
                            title: context.translation!.brand,
                            value: state.paraPharmaCatalogData.brand.name),
                        RowColumnDataHolders(
                            title: context.translation!.category,
                            value: state.paraPharmaCatalogData.category.name),
                        RowColumnDataHolders(
                            title: context.translation!.packaging,
                            value: state.paraPharmaCatalogData.packaging),
                      ],
                    ),
                    const ResponsiveGap.s24(),
                  ],
                ),
              ),
            ),
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: SizedBox(
              height: kBottomNavigationBarHeight,
              child: widget.canOrder
                  ? widget.quantitySectionBuilder(
                      state.paraPharmaCatalogData.unitPriceHt)
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
