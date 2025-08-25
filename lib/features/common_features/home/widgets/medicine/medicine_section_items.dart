import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_4.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';

class MedicinesSectionItems extends StatelessWidget {
  const MedicinesSectionItems({super.key, required this.minSectionHeight});
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: minSectionHeight * 2, minHeight: minSectionHeight),
      child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          MedicineProductsCubit medicinesCubit =
              context.read<MedicineProductsCubit>();
          final items = medicinesCubit.medicines;

          if (state is MedicineProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MedicineProductsLoadingFailed || items.isEmpty) {
            return const Center(child: EmptyListWidget());
          }

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return AspectRatio(
                aspectRatio: 1,
                child: MedicineWidget4(medicineData: items[index]),
              );
            },
          );
        },
      ),
    );
  }
}
