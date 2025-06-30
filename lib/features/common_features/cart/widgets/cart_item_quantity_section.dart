import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/models/cart_item.dart';

import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/constants.dart';

import '../../../common/buttons/solid/primary_icon_button.dart';

class QuantitySection extends StatelessWidget {
  final CartItemModel cartData;

  const QuantitySection({
    super.key,
    required this.cartData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<CartCubit>(context);
        if (state is! CartQuantityUpdated || state.updatedItemId != cartData.id) {}
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
          child: Transform.scale(
            alignment: Alignment.centerRight,
            scale: 0.85,
            child: Row(children: [
              PrimaryIconButton(
                borderColor: StrokeColors.normal.color,
                isBordered: true,
                bgColor: Colors.transparent,
                onPressed: () {
                  cubit.decreaseCartItemQuantity(cartData.id);
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
                    validator: (value) => value == null || value.isEmpty ? '' : null,
                    style: AppTypography.body1MediumStyle,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      enabledBorder: InputBorder.none,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                        borderSide: BorderSide(color: AppColors.bgDisabled),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                        borderSide: BorderSide(color: StrokeColors.focused.color),
                      ),
                    )),
              ),
              PrimaryIconButton(
                borderColor: StrokeColors.normal.color,
                isBordered: true,
                bgColor: Colors.transparent,
                onPressed: () {
                  cubit.increaseCartItemQuantity(cartData.id);
                },
                icon: Icon(
                  Iconsax.add,
                  color: Colors.black,
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
