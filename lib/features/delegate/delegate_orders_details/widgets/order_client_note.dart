import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../utils/helper_func.dart';
import '../cubit/order_details/orders_details_cubit.dart';

class DelegateClientNoteSection extends StatelessWidget {
  final ValueNotifier showMore = ValueNotifier(false);
  DelegateClientNoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p12, horizontal: context.responsiveAppSizeTheme.current.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client notes',
            style: context.responsiveTextTheme.current.headLine4SemiBold,
          ),
          const ResponsiveGap.s4(),
          ValueListenableBuilder(
            valueListenable: showMore,
            builder: (BuildContext ctx, value, Widget? child) {
              return InkWell(
                onTap: () => showMore.value = !showMore.value,
                child: calculateNumberOfLines(context.read<DelegateOrderDetails2Cubit>().state.orderData.clientNote,
                            context.responsiveTextTheme.current.bodySmall, MediaQuery.sizeOf(context).width) >
                        3
                    ? Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: <Widget>[
                          Text.rich(
                            showMore.value
                                ? TextSpan(
                                    text: context.read<DelegateOrderDetails2Cubit>().state.orderData.clientNote,
                                    style: context.responsiveTextTheme.current.bodySmall.copyWith(
                                      height: 1.5,
                                    ),
                                    children: [
                                        TextSpan(
                                            text: '(show_less)',
                                            style: context.responsiveTextTheme.current.bodySmall.copyWith(
                                              height: 1.5,
                                            ))
                                      ])
                                : TextSpan(
                                    text: context.read<DelegateOrderDetails2Cubit>().state.orderData.clientNote,
                                    style: context.responsiveTextTheme.current.bodySmall.copyWith(
                                      height: 1.5,
                                    ),
                                    children: [
                                        TextSpan(
                                          text: ' (show_more)',
                                          style: context.responsiveTextTheme.current.bodySmall.copyWith(
                                            height: 1.5,
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
                    : Text(context.read<DelegateOrderDetails2Cubit>().state.orderData.clientNote,
                        style: context.responsiveTextTheme.current.bodySmall.copyWith(
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
