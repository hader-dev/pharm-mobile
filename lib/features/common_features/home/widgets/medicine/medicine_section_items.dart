import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_4.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class MedicinesSectionItems extends StatelessWidget {
  const MedicinesSectionItems({super.key, required this.minSectionHeight});
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: minSectionHeight * 2, minHeight: minSectionHeight),
      child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          MedicineProductsCubit medicinesCubit =
              context.read<MedicineProductsCubit>();
          final items = medicinesCubit.medicines;

          if (state is MedicineProductsLoading) {
            return Text(translation.feedback_loading_failed);
          }
          if (state is MedicineProductsLoadingFailed) {
            return Text(translation.feedback_loading_failed);
          }

          if (items.isEmpty) {
            return EmptyListWidget();
          }

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0
                    ? const EdgeInsets.only(left: AppSizesManager.p4)
                    : EdgeInsets.zero,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: MedicineWidget4(medicineData: items[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
