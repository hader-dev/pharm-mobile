import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../utils/constants.dart';

class ShippingAddressSection extends StatelessWidget {
  final String address;
  final double latitude;
  final double longitude;
  const ShippingAddressSection(
      {super.key,
      required this.address,
      required this.latitude,
      required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: AppSizesManager.p12, horizontal: AppSizesManager.p4),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      ),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizesManager.p6, horizontal: AppSizesManager.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(context.translation!.shipping_address,
              style: context.responsiveTextTheme.current.headLine4SemiBold),
          const Gap(AppSizesManager.s12),
          Text(address, style: context.responsiveTextTheme.current.body3Medium),
          const Gap(AppSizesManager.s12),
          // Text(
          //     "(Lat: ${latitude.toStringAsFixed(2)} , Long: ${longitude.toStringAsFixed(2)})",
          //     style: context.responsiveTextTheme.current.body3Medium),
        ],
      ),
    );
  }
}
