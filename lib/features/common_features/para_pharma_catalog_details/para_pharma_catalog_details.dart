import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/setup_status_bar.dart';
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/info_row_column.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/trademark_widget.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

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
  static final GlobalKey<ScaffoldState> paraPharmaDetailsScaffoldKey = GlobalKey<ScaffoldState>();

  const BaseParaPharmaCatalogDetailsScreen(
      {super.key,
      required this.paraPharmaCatalogId,
      required this.canOrder,
      required this.needCartCubit,
      required this.quantitySectionBuilder,
      this.disabledPackageQuanity = false});

  @override
  State<BaseParaPharmaCatalogDetailsScreen> createState() => _BaseParaPharmaCatalogDetailsScreenState();
}

class _BaseParaPharmaCatalogDetailsScreenState extends State<BaseParaPharmaCatalogDetailsScreen>
    with TickerProviderStateMixin {
  double bottomNavbarHeightModifier = 1;

  @override
  void initState() {
    super.initState();
    setupStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    bottomNavbarHeightModifier = widget.disabledPackageQuanity
        ? context.responsiveAppSizeTheme.current.deafultQuantityNavbarHeightModifier
        : context.responsiveAppSizeTheme.current.expandedQuantityNavbarHeightModifier;
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
            key: BaseParaPharmaCatalogDetailsScreen.paraPharmaDetailsScaffoldKey,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
                      child: const ParaPharmaProductPhotoSection(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: context.responsiveAppSizeTheme.current.p16,
                          right: context.responsiveAppSizeTheme.current.p16,
                          bottom: context.responsiveAppSizeTheme.current.p8),
                      child: Row(
                        children: [
                          if (state.paraPharmaCatalogData.category != null)
                            CustomChip(
                              label: state.paraPharmaCatalogData.category!.name,
                              color: AppColors.bgDarken2,
                            ),
                          ResponsiveGap.s8(),
                          if (state.paraPharmaCatalogData.brand != null)
                            CustomChip(
                              label: state.paraPharmaCatalogData.brand!.name,
                              color: AppColors.bgDarken2,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: context.responsiveAppSizeTheme.current.p16,
                          right: context.responsiveAppSizeTheme.current.p16,
                          bottom: context.responsiveAppSizeTheme.current.p8),
                      child: Text(state.paraPharmaCatalogData.name,
                          style: context.responsiveTextTheme.current.headLine2
                              .copyWith(fontSize: 23, fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: context.responsiveAppSizeTheme.current.p16,
                          right: context.responsiveAppSizeTheme.current.p16,
                          bottom: context.responsiveAppSizeTheme.current.p10),
                      child: TrademarkWidgetAlternate(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: context.responsiveAppSizeTheme.current.p8,
                          right: context.responsiveAppSizeTheme.current.p8),
                      child: Html(
                        data: state.paraPharmaCatalogData.description,
                        style: {
                          "body": Style(
                            fontSize: FontSize(
                              MediaQuery.of(context).textScaler.scale(
                                    context.deviceSize.width <= DeviceSizes.largeMobile.width ? 16 : 25,
                                  ),
                            ),
                            lineHeight: LineHeight(1.5),
                          ),
                        },
                      ),
                    ),
                    InfoRowColumn(
                      data: [
                        RowColumnDataHolders(
                            title: context.translation!.brand, value: state.paraPharmaCatalogData.brand!.name),
                        RowColumnDataHolders(
                            title: context.translation!.category, value: state.paraPharmaCatalogData.category!.name),
                        RowColumnDataHolders(
                            title: context.translation!.packaging, value: state.paraPharmaCatalogData.packaging),
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
                  ? widget.quantitySectionBuilder(state.paraPharmaCatalogData.unitPriceHt)
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
