import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';

import '../../../../../config/services/network/network_interface.dart';
import '../../../../../repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import '../../../../common/widgets/end_of_load_result_widget.dart';

import '../../../../common/widgets/medicine_widget_2.dart';
import 'cubit/medicine_products_cubit.dart';

class MedicineProductsPage extends StatefulWidget {
  const MedicineProductsPage({super.key});

  @override
  State<MedicineProductsPage> createState() => _MedicineProductsPageState();
}

class _MedicineProductsPageState extends State<MedicineProductsPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => MedicineProductsCubit(
          scrollController: ScrollController(),
          medicineRepository: MedicineCatalogRepository(client: getItInstance.get<INetworkService>()))
        ..getMedicines(),
      child: Material(child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          if (state is MedicineProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MedicineProductsLoaded && BlocProvider.of<MedicineProductsCubit>(context).medicines.isEmpty) {
            return EmptyListWidget();
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    return BlocProvider.of<MedicineProductsCubit>(context).getMedicines();
                  },
                  child: ListView.builder(
                    controller: BlocProvider.of<MedicineProductsCubit>(context).scrollController,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: BlocProvider.of<MedicineProductsCubit>(context).medicines.length,
                    itemBuilder: (context, index) => MedicineWidget2(
                      medicineData: BlocProvider.of<MedicineProductsCubit>(context).medicines[index],
                    ),
                  ),
                ),
              ),
              if (state is LoadingMoreMedicine) const Center(child: CircularProgressIndicator()),
              if (state is MedicinesLoadLimitReached) EndOfLoadResultWidget(),
            ],
          );
        },
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
