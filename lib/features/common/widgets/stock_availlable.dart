import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class StockAvaillableWidget extends StatelessWidget {
  const StockAvaillableWidget({
    super.key,
    required this.isAvaillable,
  });

  final bool isAvaillable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        isAvaillable
            ? Icon(Iconsax.box_2,
                color: SystemColors.green.primary,
                size: context.responsiveAppSizeTheme.current.iconSize16)
            : Icon(Iconsax.box_2,
                color: SystemColors.red.primary,
                size: context.responsiveAppSizeTheme.current.iconSize16),
        const ResponsiveGap.s4(),
        Text(
            isAvaillable
                ? context.translation!.in_stock
                : context.translation!.out_stock,
            style: context.responsiveTextTheme.current.bodySmall.copyWith(
                color: SystemColors.green.primary,
                fontWeight: context
                    .responsiveTextTheme.current.appFont.appFontSemiBold)),
      ],
    );
  }
}

class StockAvaillableContainerWidget extends StatelessWidget {
  const StockAvaillableContainerWidget({
    super.key,
    required this.isAvaillable,
  });

  final bool isAvaillable;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      alignment: Alignment.topLeft,
      scale: .8,
      child: Container(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight:
                    Radius.circular(context.responsiveAppSizeTheme.current.r6),
                topLeft:
                    Radius.circular(context.responsiveAppSizeTheme.current.r6)),
            color:
                const Color.fromARGB(255, 195, 252, 222).withValues(alpha: 0.8),
          ),
          child: StockAvaillableWidget(isAvaillable: isAvaillable)),
    );
  }
}
