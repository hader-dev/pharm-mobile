import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_3.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ParaPharmaSectionItems extends StatelessWidget {
  const ParaPharmaSectionItems({super.key, required this.minSectionHeight});
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: minSectionHeight * 2, minHeight: minSectionHeight),
      child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
        builder: (context, state) {
          ParaPharmaCubit paraPharmaProductsCubit =
              context.read<ParaPharmaCubit>();
          final items = paraPharmaProductsCubit.paraPharmaProducts;

          if (state is ParaPharmaProductsLoading) {
            return Text(translation.loading);
          }
          if (state is ParaPharmaProductsLoadingFailed) {
            return Text(translation.feedback_loading_failed);
          }

          if (items.isEmpty) {
            return EmptyListWidget();
          }

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 0),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return AspectRatio(
                aspectRatio: 1,
                child: ParaPharmaWidget4(paraPharmData: items[index]),
              );
            },
          );
        },
      ),
    );
  }
}
