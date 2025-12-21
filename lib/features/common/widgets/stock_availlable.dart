import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class StockAvailableWidget extends StatelessWidget {
  const StockAvailableWidget({
    super.key,
    required this.isAvailable,
  });

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(isAvailable ? Iconsax.box_1 : Iconsax.box_2,
            color: isAvailable ? SystemColors.green.primary : SystemColors.red.primary,
            size: context.responsiveAppSizeTheme.current.iconSize16),
        const ResponsiveGap.s4(),
        Text(isAvailable ? context.translation!.in_stock : context.translation!.out_stock,
            style: context.responsiveTextTheme.current.bodySmall.copyWith(
                color: isAvailable ? SystemColors.green.primary : SystemColors.red.primary,
                fontWeight: context.responsiveTextTheme.current.appFont.appFontSemiBold)),
      ],
    );
  }
}

class StockAvailableContainerWidget extends StatelessWidget {
  const StockAvailableContainerWidget({
    super.key,
    required this.isAvailable,
  });

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      alignment: Alignment.topLeft,
      scale: .9,
      child: Container(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(context.responsiveAppSizeTheme.current.r6),
                topLeft: Radius.circular(context.responsiveAppSizeTheme.current.r6)),
            color: AppColors.bgWhite,
          ),
          child: StockAvailableWidget(isAvailable: isAvailable)),
    );
  }
}
