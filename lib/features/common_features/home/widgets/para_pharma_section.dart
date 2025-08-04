import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_3.dart';

import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';


class ParaPharmaSection extends StatelessWidget {
  const ParaPharmaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 250),
      child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
        builder: (context, state) {
          ParaPharmaCubit paraPharmaProductsCubit = context.read<ParaPharmaCubit>();
          if (state is ParaPharmaProductsLoading) {
            return Text(translation.loading);
          }
          if (state is ParaPharmaProductsLoadingFailed) {
            return Text(translation.feedback_loading_failed);
          }

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: paraPharmaProductsCubit.paraPharmaProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0 ? const EdgeInsets.only(left: AppSizesManager.p4) : EdgeInsets.zero,
                child: AspectRatio(
                  aspectRatio: 1.05,
                  child: ParaPharmaWidget4(paraPharmData: paraPharmaProductsCubit.paraPharmaProducts[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
