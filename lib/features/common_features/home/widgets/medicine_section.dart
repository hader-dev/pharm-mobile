import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/medicine_widget_3.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../common/widgets/medicine_widget_4.dart';
import '../../market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';

class MedicinesSection extends StatelessWidget {
  const MedicinesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 250),
      child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          MedicineProductsCubit medicinesCubit = context.read<MedicineProductsCubit>();
          if (state is MedicineProductsLoading) {
            return Text("Loading");
          }
          if (state is MedicineProductsLoadingFailed) {
            return Text("Loading Failed");
          }

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: medicinesCubit.medicines.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0 ? const EdgeInsets.only(left: AppSizesManager.p4) : EdgeInsets.zero,
                child: AspectRatio(
                  aspectRatio: 1.05,
                  child: MedicineWidget4(medicineData: medicinesCubit.medicines[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
