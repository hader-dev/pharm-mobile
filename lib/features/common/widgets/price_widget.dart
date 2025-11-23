import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

class PriceWidget extends StatelessWidget {
  final double price;
  final double? overridePrice;
  final TextStyle? mainStyle;
  final TextStyle? currencyStyle;

  const PriceWidget({
    super.key,
    required this.price,
    this.overridePrice,
    this.mainStyle,
    this.currencyStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultMainStyle = context
        .responsiveTextTheme.current.headLine4SemiBold
        .copyWith(color: AppColors.accent1Shade1);

    final defaultCurrencyStyle =
        context.responsiveTextTheme.current.bodyXSmall.copyWith(
      color: AppColors.accent1Shade1,
    );

    final main = mainStyle ?? defaultMainStyle;
    final currency = currencyStyle ?? defaultCurrencyStyle;

    if (overridePrice == null) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: price.formatAsPriceForPrint(decimalDigits: 1),
              style: main,
            ),
            TextSpan(
              text: " ${context.translation!.currency}",
              style: currency,
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: price.formatAsPriceForPrint(decimalDigits: 1),
                style: main.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
              TextSpan(
                text: " ${context.translation!.currency}",
                style: currency.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: overridePrice!.formatAsPriceForPrint(decimalDigits: 1),
                style: main,
              ),
              TextSpan(
                text: " ${context.translation!.currency}",
                style: currency,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
