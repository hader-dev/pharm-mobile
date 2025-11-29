import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors, TextColors;
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart' show CartCubit, CartState;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef OnQuantityChanged = void Function(String quantity);

class CartQuantitySection extends StatelessWidget {
  final double buttonSize = 20;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final VoidCallback decrement;
  final TextEditingController quantityController;
  final VoidCallback increment;
  final CrossAxisAlignment crossAxisAlignment;
  final Function(String quantity)? onQuantityChanged;
  final bool displayQuantityLabel;
  final Axis axisDirection;
  final MainAxisAlignment mainAxisAlignment;
  final int maxQuantity;
  final int minQuantity;

  CartQuantitySection({
    super.key,
    required this.decrement,
    required this.increment,
    this.maxQuantity = 9999,
    this.minQuantity = 1,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.onQuantityChanged,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.axisDirection = Axis.horizontal,
    this.displayQuantityLabel = true,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Row(
          children: [
            InkWell(
              onTap: decrement,
              child: Container(
                decoration: BoxDecoration(
                  color: int.parse(quantityController.text) == minQuantity
                      ? Colors.grey.shade200
                      : AppColors.accentGreenShade1.withAlpha(30),
                  borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                ),
                padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.s2),
                child: Icon(
                  Icons.remove,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.s2),
              width: context.responsiveAppSizeTheme.current.p24 * 1.9,
              height: context.responsiveAppSizeTheme.current.p32,
              child: Form(
                child: TextFormField(
                  cursorColor: AppColors.accentGreenShade1,
                  controller: quantityController,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => value == null || value.isEmpty ? '' : null,
                  style: context.responsiveTextTheme.current.body3Medium.copyWith(color: TextColors.primary.color),
                  decoration: InputDecoration(
                    hintText: quantityController.text,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        context.responsiveAppSizeTheme.current.commonWidgetsRadius,
                      ),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        context.responsiveAppSizeTheme.current.commonWidgetsRadius,
                      ),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        context.responsiveAppSizeTheme.current.commonWidgetsRadius,
                      ),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: increment,
              child: Container(
                decoration: BoxDecoration(
                  color: int.parse(quantityController.text) == maxQuantity
                      ? Colors.grey.shade200
                      : AppColors.accentGreenShade1.withAlpha(30),
                  borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                ),
                padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.s2),
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
