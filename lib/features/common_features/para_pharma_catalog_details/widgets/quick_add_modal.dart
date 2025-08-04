import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/helpers/para_pharma_catalog_details_tab_data.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/buttons_section.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

class QuickCartAddModal extends StatefulWidget {
  const QuickCartAddModal({super.key, required this.paraPharmaCatalogId});
  final String paraPharmaCatalogId;

  @override
  State<QuickCartAddModal> createState() => _QuickCartAddModalState();
}

class _QuickCartAddModalState extends State<QuickCartAddModal>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final cartCubit =
        AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>();

    final existingCartItem = cartCubit.getItemIfExists(widget.paraPharmaCatalogId,true);

    final tabs = paraPharmaCatalogDetailsTabData(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ParaPharmaDetailsCubit(
            quantityController: TextEditingController(text: existingCartItem?.quantity.toString() ?? '1'),
              tabController: TabController(length: tabs.length, vsync: this),
              ordersRepository:
                  OrderRepository(client: getItInstance.get<INetworkService>()),
              paraPharmaCatalogRepository: ParaPharmaRepository(
                  client: getItInstance.get<INetworkService>()))
            ..getParaPharmaCatalogData(widget.paraPharmaCatalogId),
        ),
        BlocProvider.value(value: cartCubit),
      ],
      child: ButtonsSection(
        onAction: () => context.pop(),
        quantitySectionAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
