import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';

import '../../../config/di/di.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import '../../../utils/constants.dart';
import 'cubit/para_pharma_details_cubit.dart';
import 'sub_pages/para_pharma_catalog_overview/para_pharma_catalog_overview.dart';

import 'widgets/buttons_section.dart';
import 'widgets/header_section.dart';

import 'widgets/para_pharma_product_photo_section.dart';
import 'widgets/tap_bar_section.dart';

class ParaPharmaCatalogDetailsScreen extends StatefulWidget {
  final String paraPharmaCatalogId;
  static const List<String> tabs = ['Product overview'];
  const ParaPharmaCatalogDetailsScreen({super.key, required this.paraPharmaCatalogId});

  @override
  State<ParaPharmaCatalogDetailsScreen> createState() => _ParaPharmaCatalogDetailsScreenState();
}

class _ParaPharmaCatalogDetailsScreenState extends State<ParaPharmaCatalogDetailsScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => ParaPharmaDetailsCubit(
            tabController: TabController(length: ParaPharmaCatalogDetailsScreen.tabs.length, vsync: this),
            paraPharmaCatalogRepository: ParaPharmaRepository(client: getItInstance.get<INetworkService>()))
          ..getParaPharmaCatalogData(widget.paraPharmaCatalogId),
        child: Scaffold(body: BlocBuilder<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
          builder: (context, state) {
            if (state is ParaPharmaDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ParaPharmaDetailsLoadError) {
              return Center(child: Text('Failed to load para-pharma details'));
            }
            return Column(
              children: [
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ParaPharmaProductPhotoSection(),
                      HeaderSection(),
                      Divider(color: AppColors.bgDisabled, thickness: 3.5, height: 1),
                      ProductDetailsTabBarSection(),
                      Gap(AppSizesManager.s24),

                      ParaPharmaOverViewPage(),

                      Divider(color: AppColors.bgDisabled, thickness: 3.5, height: 1),
                      // OtherProductsSection(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSizesManager.p12),
                  child: ButtonsSection(),
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}
