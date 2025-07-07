import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../config/theme/typoghrapy_manager.dart';

import '../../../../utils/helper_func.dart';
import '../cubit/orders_details_cubit.dart';

class ClientNoteSection extends StatelessWidget {
  final ValueNotifier showMore = ValueNotifier(false);
  ClientNoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p12, horizontal: AppSizesManager.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client notes',
            style: AppTypography.headLine4SemiBoldStyle,
          ),
          Gap(AppSizesManager.s4),
          ValueListenableBuilder(
            valueListenable: showMore,
            builder: (BuildContext ctx, value, Widget? child) {
              return InkWell(
                onTap: () => showMore.value = !showMore.value,
                child: calculateNumberOfLines(context.read<OrderDetailsCubit>().orderData!.clientNote,
                            AppTypography.bodySmallStyle, MediaQuery.sizeOf(context).width) >
                        3
                    ? Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: <Widget>[
                          Text.rich(
                            showMore.value
                                ? TextSpan(
                                    text: context.read<OrderDetailsCubit>().orderData!.clientNote,
                                    style: AppTypography.bodySmallStyle.copyWith(
                                      height: 1.5,
                                      fontWeight: AppTypography.appFontRegular,
                                    ),
                                    children: [
                                        TextSpan(
                                          text: '(show_less)',
                                          style: AppTypography.bodySmallStyle.copyWith(
                                            height: 1.5,
                                            fontWeight: AppTypography.appFontRegular,
                                          ),
                                        )
                                      ])
                                : TextSpan(
                                    text: context.read<OrderDetailsCubit>().orderData!.clientNote,
                                    style: AppTypography.bodySmallStyle.copyWith(
                                      height: 1.5,
                                      fontWeight: AppTypography.appFontRegular,
                                    ),
                                    children: [
                                        TextSpan(
                                          text: ' (show_more)',
                                          style: AppTypography.bodySmallStyle.copyWith(
                                            height: 1.5,
                                            fontWeight: AppTypography.appFontRegular,
                                          ),
                                        )
                                      ]),
                            softWrap: true,
                            maxLines: showMore.value ? null : 2,
                          ),
                          showMore.value
                              ? const SizedBox.shrink()
                              : Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                )
                        ],
                      )
                    : Text(context.read<OrderDetailsCubit>().orderData!.clientNote,
                        style: AppTypography.bodySmallStyle.copyWith(
                          height: 1.5,
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}
