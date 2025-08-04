import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart'
    show CartCubit;
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/helpers/para_pharma_catalog_details_tab_data.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../app_layout/app_layout.dart' show AppLayout;
import 'cubit/para_pharma_details_cubit.dart';
import 'sub_pages/para_pharma_catalog_overview/para_pharma_catalog_overview.dart';

import 'widgets/buttons_section.dart';
import 'widgets/header_section.dart';

import 'widgets/para_pharma_product_photo_section.dart';
import 'widgets/tap_bar_section.dart';

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
    final tabs = paraPharmaCatalogDetailsTabData(context);

    final cartCubit =
        AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>();
    final existingCartItem =
        cartCubit.getItemIfExists(widget.paraPharmaCatalogId,true);

    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ParaPharmaDetailsCubit(
                quantityController: TextEditingController(
                    text: existingCartItem?.quantity.toString() ?? '1'),
                tabController: TabController(length: tabs.length, vsync: this),
                ordersRepository: OrderRepository(
                    client: getItInstance.get<INetworkService>()),
                paraPharmaCatalogRepository: ParaPharmaRepository(
                    client: getItInstance.get<INetworkService>()))
              ..getParaPharmaCatalogData(widget.paraPharmaCatalogId),
          ),
          BlocProvider.value(
              value: AppLayout.appLayoutScaffoldKey.currentContext!
                  .read<CartCubit>()),
        ],
        child: Scaffold(
            key: ParaPharmaCatalogDetailsScreen.paraPharmaDetailsScaffoldKey,
            body: BlocBuilder<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
              builder: (context, state) {
                if (state is ParaPharmaDetailsLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ParaPharmaDetailsLoadError) {
                  return Center(
                      child: Text(context.translation!
                          .feedback_failed_to_load_para_pharma_details));
                }
                return Column(
                  children: [
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ParaPharmaProductPhotoSection(),
                          HeaderSection(),
                          Divider(
                              color: AppColors.bgDisabled,
                              thickness: 3.5,
                              height: 1),
                          ProductDetailsTabBarSection(),
                          Gap(AppSizesManager.s24),

                          ParaPharmaOverViewPage(),

                          Divider(
                              color: AppColors.bgDisabled,
                              thickness: 3.5,
                              height: 1),
                          // OtherProductsSection(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSizesManager.p12),
                      child: ButtonsSection(
                        quantitySectionAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
