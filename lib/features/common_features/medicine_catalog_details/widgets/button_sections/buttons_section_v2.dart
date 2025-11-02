import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/add_cart_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../make_order_bottom_sheet.dart' show MakeOrderBottomSheet;

class ButtonsSectionV2 extends StatelessWidget {
  const ButtonsSectionV2({
    super.key,
    this.onAction,
    this.quantitySectionAlignment = MainAxisAlignment.end,
    this.disabledPackageQuanity = true,
    this.price,
  });

  final VoidCallback? onAction;
  final MainAxisAlignment quantitySectionAlignment;
  final bool disabledPackageQuanity;
  final double? price;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<MedicineDetailsCubit>();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.responsiveAppSizeTheme.current.p4),
          child: Row(
            children: [
              Expanded(
                child: PrimaryTextButton(
                  isOutLined: true,
                  label: translation.buy_now,
                  spalshColor: AppColors.accent1Shade1.withAlpha(50),
                  labelColor: AppColors.accent1Shade1,
                  borderColor: AppColors.accent1Shade1,
                  maxWidth: MediaQuery.of(context).size.width * 0.25,
                  leadingIcon: Iconsax.money4,
                  onTap: () {
                    BottomSheetHelper.showCommonBottomSheet(
                            context: context,
                            child: MakeOrderBottomSheet(cubit: cubit))
                        .then((res) => onAction?.call());
                  },
                ),
              ),
              const ResponsiveGap.s8(),
              Expanded(
                child: PrimaryTextButton(
                  label: translation.add_cart,
                  leadingIcon: Iconsax.add,
                  color: AppColors.accent1Shade1,
                  onTap: () {
                    BottomSheetHelper.showCommonBottomSheet(
                      context: context,
                      child: AddCartBottomSheet(
                        cubit: cubit,
                        onAction: onAction,
                        needCartCubit: true,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
