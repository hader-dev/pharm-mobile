import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'cart_item.dart';

// }

class VendorCartSection extends StatefulWidget {
  final BaseCompany vendorData;
  final List<String> cartItems;

  const VendorCartSection(
      {super.key, required this.vendorData, required this.cartItems});

  @override
  State createState() => VendorCartSectionState();
}

class VendorCartSectionState extends State<VendorCartSection> {
  final ValueNotifier _isExpanded = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p8,
          vertical: context.responsiveAppSizeTheme.current.s8),
      child: ValueListenableBuilder(
        valueListenable: _isExpanded,
        builder: (context, value, child) => ExpansionTile(
          dense: true,
          initiallyExpanded: _isExpanded.value,
          trailing: Icon(_isExpanded.value
              ? Icons.minimize
              : Icons.keyboard_arrow_down_outlined),
          iconColor: AppColors.accent1Shade1,
          maintainState: true,
          childrenPadding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p8,
              horizontal: context.responsiveAppSizeTheme.current.p8),
          expandedAlignment: Alignment.centerLeft,
          tilePadding: EdgeInsets.symmetric(
              horizontal: context.responsiveAppSizeTheme.current.p8),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  context.responsiveAppSizeTheme.current.r8),
              side: BorderSide(color: StrokeColors.normal.color)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  context.responsiveAppSizeTheme.current.r8),
              side: BorderSide(color: StrokeColors.focused.color)),
          title: Row(children: [
            Container(
              height: context.responsiveAppSizeTheme.current.iconSize30,
              width: context.responsiveAppSizeTheme.current.iconSize30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                image: DecorationImage(
                  image: widget.vendorData.thumbnailImage == null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(getItInstance
                          .get<INetworkService>()
                          .getFilesPath(
                              widget.vendorData.thumbnailImage!.path)),
                ),
              ),
            ),
            const ResponsiveGap.s4(),
            Text.rich(
              TextSpan(
                text: widget.vendorData.name,
                style: context.responsiveTextTheme.current.body1Medium.copyWith(
                    fontWeight: context
                        .responsiveTextTheme.current.appFont.appFontSemiBold,
                    color: TextColors.primary.color),
                children: [
                  TextSpan(
                      text: " (${widget.cartItems.length})",
                      style: context.responsiveTextTheme.current.bodySmall
                          .copyWith(color: TextColors.ternary.color)),
                ],
              ),
            )
          ]),
          onExpansionChanged: (value) {
            _isExpanded.value = value;
          },
          children: widget.cartItems
              .map((e) => CartItemWidget(
                  item: BlocProvider.of<CartCubit>(context)
                      .state
                      .cartItems
                      .firstWhere((item) => item.model.id == e)))
              .toList(),
        ),
      ),
    );
  }
}
