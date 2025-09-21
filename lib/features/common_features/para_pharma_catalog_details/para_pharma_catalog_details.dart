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
import 'widgets/buttons_section.dart';
import 'widgets/header_section.dart';
import 'widgets/para_pharma_product_photo_section.dart';

class ParaPharmaCatalogDetailsScreen extends StatefulWidget {
  final String paraPharmaCatalogId;
  static final GlobalKey<ScaffoldState> paraPharmaDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();
  const ParaPharmaCatalogDetailsScreen(
      {super.key, required this.paraPharmaCatalogId});

  @override
  State<ParaPharmaCatalogDetailsScreen> createState() =>
      _ParaPharmaCatalogDetailsScreenState();
}

class _ParaPharmaCatalogDetailsScreenState
    extends State<ParaPharmaCatalogDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StateProvider(
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
                  Center(child: EmptyListWidget()),
                ],
              );
            }
            return Scaffold(
              key: ParaPharmaCatalogDetailsScreen.paraPharmaDetailsScaffoldKey,
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
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(AppSizesManager.p12),
                child: SizedBox(
                  height: kBottomNavigationBarHeight * 3,
                  child: ButtonsSection(
                    quantitySectionAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
