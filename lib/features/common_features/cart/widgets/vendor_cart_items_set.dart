import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/models/company.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/assets_strings.dart';
import '../../../../utils/constants.dart';
import '../cubit/cart_cubit.dart';
import 'cart_item.dart';

// }

class VendorCartSection extends StatefulWidget {
  final BaseCompany vendorData;
  final List<String> cartItems;

  const VendorCartSection({super.key, required this.vendorData, required this.cartItems});

  @override
  State createState() => VendorCartSectionState();
}

class VendorCartSectionState extends State<VendorCartSection> {
  final ValueNotifier _isExpanded = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p8, vertical: AppSizesManager.s8),
      child: ValueListenableBuilder(
        valueListenable: _isExpanded,
        builder: (context, value, child) => ExpansionTile(
          dense: true,
          initiallyExpanded: _isExpanded.value,
          trailing: Icon(_isExpanded.value ? Icons.minimize : Icons.keyboard_arrow_down_outlined),
          iconColor: AppColors.accent1Shade1,
          maintainState: true,
          childrenPadding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8, horizontal: AppSizesManager.p8),
          expandedAlignment: Alignment.centerLeft,
          tilePadding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.r8),
              side: BorderSide(color: StrokeColors.normal.color)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.r8),
              side: BorderSide(color: StrokeColors.focused.color)),
          title: Row(children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                image: DecorationImage(
                  image: widget.vendorData.image == null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(widget.vendorData.thumbnailImage),
                ),
              ),
            ),
            Gap(AppSizesManager.s4),
            Text.rich(
              TextSpan(
                text: widget.vendorData.name,
                style: AppTypography.bodySmallStyle
                    .copyWith(fontWeight: AppTypography.appFontSemiBold, color: TextColors.primary.color),
                children: [
                  TextSpan(
                      text: " (${widget.cartItems.length})",
                      style: AppTypography.bodyXSmallStyle.copyWith(color: TextColors.ternary.color)),
                ],
              ),
            )
          ]),
          onExpansionChanged: (value) {
            _isExpanded.value = value;
          },
          children: widget.cartItems
              .map((e) => CartItemWidget(
                  cartItemData: BlocProvider.of<CartCubit>(context).cartItems.firstWhere((item) => item.id == e)))
              .toList(),
        ),
      ),
    );
  }
}
