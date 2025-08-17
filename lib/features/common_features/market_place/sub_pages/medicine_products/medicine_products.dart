import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_2.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/floating_filter.dart';
import 'cubit/medicine_products_cubit.dart';

class MedicineProductsPage extends StatefulWidget {
  const MedicineProductsPage({super.key});

  @override
  State<MedicineProductsPage> createState() => _MedicineProductsPageState();
}

class _MedicineProductsPageState extends State<MedicineProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
            builder: (context, state) {
              final cubit = BlocProvider.of<MedicineProductsCubit>(context);
              final medicines = cubit.medicines;

              if (state is MedicineProductsLoadingFailed) {
                return const Center(child: EmptyListWidget());
              }
              if (state is MedicineProductsLoading && medicines.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MedicineProductsLoaded && medicines.isEmpty) {
                return const Center(child: EmptyListWidget());
              }

              final bool isLoadingMore = state is MedicineProductsLoading;
              final bool hasReachedEnd = state is MedicinesLoadLimitReached;

              return RefreshIndicator(
                onRefresh: () => cubit.getMedicines(),
                child: ListView.builder(
                  controller: cubit.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: medicines.length +
                      (isLoadingMore || hasReachedEnd ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < medicines.length) {
                      final medicine = medicines[index];
                      return MedicineWidget2(
                        hideLikeButton: false,
                        medicineData: medicine,
                        isLiked: medicine.isLiked,
                        onLikeTapped: () {
                          final id = medicine.id;
                          medicine.isLiked
                              ? cubit.unlikeMedicinesCatalog(id)
                              : cubit.likeMedicinesCatalog(id);
                        },
                      );
                    } else {
                      if (isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (hasReachedEnd) {
                        return const EndOfLoadResultWidget();
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        )
      ],
    ),
    floatingActionButton: FloatingFilterMedical(),
    
    );
  }

  @override
  bool get wantKeepAlive => true;
}
