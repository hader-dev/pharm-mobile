import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class RowColumnDataHolders {
  final String title;
  final String value;
  RowColumnDataHolders({required this.title, required this.value});
}

class InfoRowColumn extends StatelessWidget {
  const InfoRowColumn({
    super.key,
    required this.data,
  });

  final List<RowColumnDataHolders> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizesManager.p16),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (int i = 0; i < data.length; i++) ...[
              Text(
                data[i].title,
                style: context.responsiveTextTheme.current.body1Medium
                    .copyWith(color: Colors.grey),
              ),
              if (i < data.length - 1) const ResponsiveGap.s8(),
            ]
          ]),
          const ResponsiveGap.s32(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (int i = 0; i < data.length; i++) ...[
              Text(
                data[i].value,
                style: context.responsiveTextTheme.current.body1Medium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (i < data.length - 1) const ResponsiveGap.s8(),
            ]
          ])
        ],
      ),
    );
  }
}
