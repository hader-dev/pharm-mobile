import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/helpers/medicine_catalog_details_tab_data.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/buttons_section.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';

class QuickCartAddModal extends StatefulWidget {
  const QuickCartAddModal(
      {super.key,
      required this.medicineCatalogId,
      this.disabledPackageQuanity = false});
  final String medicineCatalogId;
  final bool disabledPackageQuanity;

  @override
  State<QuickCartAddModal> createState() => _QuickCartAddModalState();
}

class _QuickCartAddModalState extends State<QuickCartAddModal>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final cartCubit =
        AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>();
    final existingCartItem =
        cartCubit.getItemIfExists(widget.medicineCatalogId);

    final tabs = medicineCatalogDetailsTabData(context);

    final medicineDetailsCubit = MedicineDetailsCubit(
        packageQuantityController: TextEditingController(
            text: existingCartItem?.model.quantity.toString() ?? '1'),
        quantityController: TextEditingController(
            text: existingCartItem?.model.quantity.toString() ?? '1'),
        tabController: TabController(length: tabs.length, vsync: this),
        shippingAddress: getItInstance.get<UserManager>().currentUser.address,
        ordersRepository:
            OrderRepository(client: getItInstance.get<INetworkService>()),
        medicineCatalogRepository: MedicineCatalogRepository(
            client: getItInstance.get<INetworkService>()),
        favoriteRepository:
            FavoriteRepository(client: getItInstance.get<INetworkService>()));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => medicineDetailsCubit
            ..getMedicineCatalogData(widget.medicineCatalogId),
        ),
        BlocProvider.value(value: cartCubit),
      ],
      child: ButtonsSection(
        onAction: () => context.pop(),
        price: medicineDetailsCubit.state.medicineCatalogData.unitPriceHt,
        quantitySectionAlignment: MainAxisAlignment.center,
        medicineDetailsCubit: medicineDetailsCubit,
        disabledPackageQuanity: widget.disabledPackageQuanity,
      ),
    );
  }
}
