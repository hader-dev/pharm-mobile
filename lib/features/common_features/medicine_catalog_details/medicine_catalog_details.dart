import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

import '../../../config/di/di.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../utils/constants.dart';
import '../../app_layout/app_layout.dart';
import 'cubit/medicine_details_cubit.dart';
import 'sub_pages/medcine_catalog_overview/medcine_catalog_overview.dart';
import 'sub_pages/distribitor_details/distribitor_details.dart';
import 'widgets/buttons_section.dart';
import 'widgets/header_section.dart';

import 'widgets/medicine_product_photo_section.dart';
import 'widgets/tap_bar_section.dart';

class MedicineCatalogDetailsScreen extends StatefulWidget {
  final String medicineCatalogId;
  static const List<String> tabs = ['Medicine overview', 'About distributor'];
  const MedicineCatalogDetailsScreen({super.key, required this.medicineCatalogId});

  @override
  State<MedicineCatalogDetailsScreen> createState() => _MedicineCatalogDetailsScreenState();
}

class _MedicineCatalogDetailsScreenState extends State<MedicineCatalogDetailsScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MedicineDetailsCubit(
                quantityController: TextEditingController(text: '1'),
                tabController: TabController(length: MedicineCatalogDetailsScreen.tabs.length, vsync: this),
                medicineCatalogRepository: MedicineCatalogRepository(client: getItInstance.get<INetworkService>()))
              ..getMedicineCatalogData(widget.medicineCatalogId),
          ),
          BlocProvider.value(value: AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>()),
        ],
        child: BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartItemAdded) {
              getItInstance.get<ToastManager>().showToast(type: ToastType.success, message: 'Item added to cart');
            }
          },
          child: Scaffold(body: BlocBuilder<MedicineDetailsCubit, MedicineDetailsState>(
            builder: (context, state) {
              if (state is MedicineDetailsLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is MedicineDetailsLoadError) {
                return Center(child: Text('Failed to load medicine details'));
              }

              return Column(
                children: [
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        MedicineProductPhotoSection(),
                        HeaderSection(),
                        Divider(color: AppColors.bgDisabled, thickness: 3.5, height: 1),
                        ProductDetailsTabBarSection(),
                        Gap(AppSizesManager.s24),

                        if (BlocProvider.of<MedicineDetailsCubit>(context).tabController.index == 0)
                          MedicineOverViewPage(),
                        if (BlocProvider.of<MedicineDetailsCubit>(context).tabController.index == 1)
                          DistributorDetailsPage(),

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
      ),
    );
  }
}
