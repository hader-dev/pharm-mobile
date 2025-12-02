import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart' show CacheNetworkImagePlus;
import 'package:flutter/material.dart' show Colors, InkWell, Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart' show CustomChip;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart' show ResponsiveGap;
import 'package:hader_pharm_mobile/utils/enums.dart' show DistributorCategory, DistributorCategoryDisplayNameExtension;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/theme/colors_manager.dart' show AppColors;

class VendorHomeWidget extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final VoidCallback? onPress;
  final dynamic distributorCategory;

  final String fallbackAssetImagePlaceholderPath;

  const VendorHomeWidget(
      {super.key,
      required this.title,
      required this.imageUrl,
      this.onPress,
      required this.fallbackAssetImagePlaceholderPath,
      required this.distributorCategory});

  @override
  Widget build(BuildContext context) {
    var distributorCategory = DistributorCategory.values
        .firstWhere((element) => element.id == this.distributorCategory, orElse: () => DistributorCategory.Both);
    return InkWell(
      onTap: onPress,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        margin: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p12),
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          border: Border.all(
            color: const Color.fromARGB(186, 245, 245, 245),
          ),
          borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
                clipBehavior: Clip.antiAlias,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.bgWhite,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accent1Shade1.withAlpha(30),
                  ),
                ),
                child: (imageUrl != null && imageUrl!.isNotEmpty)
                    ? CacheNetworkImagePlus(
                        imageUrl: imageUrl!,
                        boxFit: BoxFit.fill,
                      )
                    : SvgPicture.asset(
                        fallbackAssetImagePlaceholderPath,
                        fit: BoxFit.fitWidth,
                        colorFilter: ColorFilter.mode(Colors.grey.shade200, BlendMode.srcIn),
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: context.responsiveTextTheme.current.headLine3SemiBold,
                        ),
                      ),
                      const ResponsiveGap.s8(),
                      IntrinsicWidth(
                        child: Container(
                            child: distributorCategory != DistributorCategory.Both
                                ? Row(
                                    children: [
                                      CustomChip(
                                          label: distributorCategory.displayName(context.translation!),
                                          labelColor: distributorCategory.color,
                                          labelStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(
                                              fontWeight: context.responsiveTextTheme.current.appFont.appFontBold,
                                              color: distributorCategory.color),
                                          color: distributorCategory.color.withAlpha(50)),
                                      Spacer()
                                    ],
                                  )
                                : Row(
                                    children: [
                                      CustomChip(
                                          label: DistributorCategory.Pharmacy.displayName(context.translation!),
                                          labelColor: distributorCategory.color,
                                          labelStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(
                                              fontWeight: context.responsiveTextTheme.current.appFont.appFontBold,
                                              color: distributorCategory.color),
                                          color: distributorCategory.color.withAlpha(50)),
                                      ResponsiveGap.s6(),
                                      CustomChip(
                                          label: DistributorCategory.ParaPharmacy.displayName(context.translation!),
                                          labelColor: distributorCategory.color,
                                          labelStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(
                                              fontWeight: context.responsiveTextTheme.current.appFont.appFontBold,
                                              color: distributorCategory.color),
                                          color: distributorCategory.color.withAlpha(50)),
                                      Spacer()
                                    ],
                                  )),
                      ),
                      const ResponsiveGap.s8(),
                      InkWell(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Explore',
                              style: context.responsiveTextTheme.current.body3Medium.copyWith(
                                color: AppColors.accent1Shade1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_sharp,
                              color: AppColors.accent1Shade1,
                              size: context.responsiveAppSizeTheme.current.iconSize20,
                            ),
                          ],
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
