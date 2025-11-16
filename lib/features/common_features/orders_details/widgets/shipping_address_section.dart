import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart' show TextColors;

class ShippingAddressSection extends StatelessWidget {
  final String address;
  final double latitude;
  final double longitude;
  const ShippingAddressSection({super.key, required this.address, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p12, horizontal: context.responsiveAppSizeTheme.current.p4),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      padding: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p6, horizontal: context.responsiveAppSizeTheme.current.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(context.translation!.shipping_address, style: context.responsiveTextTheme.current.headLine4SemiBold),
          const ResponsiveGap.s12(),
          Text(address,
              style: context.responsiveTextTheme.current.body2Medium.copyWith(color: TextColors.ternary.color)),
        ],
      ),
    );
  }
}
