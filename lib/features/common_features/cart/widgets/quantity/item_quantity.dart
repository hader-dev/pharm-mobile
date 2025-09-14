import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/models/cart_item.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class CartItemQuantity extends StatelessWidget {
  const CartItemQuantity({super.key, required this.cartData});
  final CartItemModel cartData;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
      child: Transform.scale(
        alignment: Alignment.centerRight,
        scale: 0.82,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          PrimaryIconButton(
            borderColor: StrokeColors.normal.color,
            isBordered: true,
            bgColor: Colors.transparent,
            onPressed: () {
              cubit.decreaseCartPackageQuantity(cartData.id);
            },
            icon: Icon(
              Iconsax.minus,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: AppSizesManager.buttonHeight,
            width: 60,
            child: TextFormField(
                key: ValueKey(cartData.quantity.toString()),
                cursorColor: AppColors.accentGreenShade1,
                initialValue: cartData.quantity.toString(),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) =>
                    value == null || value.isEmpty ? '' : null,
                style: context.responsiveTextTheme.current.body1Medium,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  enabledBorder: InputBorder.none,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        AppSizesManager.commonWidgetsRadius),
                    borderSide: BorderSide(color: AppColors.bgDisabled),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        AppSizesManager.commonWidgetsRadius),
                    borderSide: BorderSide(color: StrokeColors.focused.color),
                  ),
                )),
          ),
          PrimaryIconButton(
            borderColor: StrokeColors.normal.color,
            isBordered: true,
            bgColor: Colors.transparent,
            onPressed: () {
              cubit.increaseCartPackageQuantity(cartData.id);
            },
            icon: Icon(
              Iconsax.add,
              color: Colors.black,
            ),
          ),
        ]),
      ),
    );
  }
}
