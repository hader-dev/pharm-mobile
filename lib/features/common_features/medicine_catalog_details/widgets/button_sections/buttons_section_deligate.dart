import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/add_cart_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ButtonsSectionDeligate extends StatelessWidget {
  const ButtonsSectionDeligate({
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
          padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
          child: PrimaryTextButton(
            label: translation.add_cart,
            leadingIcon: Iconsax.add,
            color: AppColors.accent1Shade1,
            onTap: () {
              BottomSheetHelper.showCommonBottomSheet(
                context: context,
                child: AddCartBottomSheet(
                  cubit: cubit,
                  deligateCreateOrderCubit: DeligateMarketPlaceScreen
                      .marketPlaceScaffoldKey.currentContext
                      ?.read<DeligateCreateOrderCubit>(),
                  onAction: onAction,
                  needCartCubit: false,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
