import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class RowColumnDataHolders {
  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  RowColumnDataHolders({required this.title, required this.value, this.titleStyle, this.valueStyle});
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
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (int i = 0; i < data.length; i++) ...[
              Text(
                data[i].title,
                style:
                    data[i].titleStyle ?? context.responsiveTextTheme.current.body1Medium.copyWith(color: Colors.grey),
              ),
              if (i < data.length - 1) const ResponsiveGap.s8(),
            ]
          ]),
          const ResponsiveGap.s32(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (int i = 0; i < data.length; i++) ...[
              Text(
                data[i].value,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: data[i].valueStyle ??
                    context.responsiveTextTheme.current.body2Medium.copyWith(
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
