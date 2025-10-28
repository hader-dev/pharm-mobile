import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/appbar.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import 'cubit/para_pharma_details_cubit.dart';
import 'cubit/provider.dart';
import 'sub_pages/para_pharma_catalog_overview/para_pharma_catalog_overview.dart';
import 'widgets/header_section.dart';
import 'widgets/para_pharma_product_photo_section.dart';

typedef QuantitySectionBuilder = Widget Function(double unitPrice);

class BaseParaPharmaCatalogDetailsScreen extends StatefulWidget {
  final String paraPharmaCatalogId;
  final bool canOrder;
  final bool disabledPackageQuanity;
  // final Widget buttonSections;
  final bool needCartCubit;
  final QuantitySectionBuilder quantitySectionBuilder;
  static final GlobalKey<ScaffoldState> paraPharmaDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();

  const BaseParaPharmaCatalogDetailsScreen(
      {super.key,
      required this.paraPharmaCatalogId,
      required this.canOrder,
      // required this.buttonSections,
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
    bottomNavbarHeightModifier = widget.disabledPackageQuanity
        ? AppSizesManager.deafultQuantityNavbarHeightModifier
        : AppSizesManager.expendedQuantityNavbarHeightModifier;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StateProvider(
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
              key: BaseParaPharmaCatalogDetailsScreen
                  .paraPharmaDetailsScaffoldKey,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: const Column(
                      children: [
                        ParaPharmaProductPhotoSection(),
                        HeaderSection(),
                        Divider(
                            color: AppColors.bgDisabled,
                            thickness: 3.5,
                            height: 1),
                        ResponsiveGap.s24(),
                        ParaPharmaOverViewPage(),
                        ResponsiveGap.s24(),
                        Divider(
                            color: AppColors.bgDisabled,
                            thickness: 3.5,
                            height: 1),
                      ],
                    ),
                  ),
                  const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: ParaPharmaCatalogAppBar()),
                ],
              ),
              resizeToAvoidBottomInset: true,
              bottomNavigationBar: widget.canOrder
                  ? AnimatedPadding(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom +
                            AppSizesManager.p12,
                        left: AppSizesManager.p12,
                        right: AppSizesManager.p12,
                      ),
                      child: SizedBox(
                          height: kBottomNavigationBarHeight *
                              bottomNavbarHeightModifier,
                          child: widget.quantitySectionBuilder(
                              state.paraPharmaCatalogData.unitPriceHt)),
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
