import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

class PriceWidget extends StatelessWidget {
  final double price;
  final double? overridePrice;
  final TextStyle? mainStyle;
  final TextStyle? currencyStyle;
  final TextStyle? linedStyle;
  final int? quantity;

  const PriceWidget({
    super.key,
    required this.price,
    this.overridePrice,
    this.mainStyle,
    this.currencyStyle,
    this.linedStyle,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final defaultMainStyle = context
        .responsiveTextTheme.current.headLine4SemiBold
        .copyWith(color: AppColors.accent1Shade1);

    final defaultLinedStyle =
        context.responsiveTextTheme.current.body3Medium.copyWith(
      decoration: TextDecoration.lineThrough,
      color: Colors.grey,
    );

    final defaultCurrencyStyle =
        context.responsiveTextTheme.current.bodyXSmall.copyWith(
      color: AppColors.accent1Shade1,
    );

    final line = linedStyle ?? defaultLinedStyle;
    final main = mainStyle ?? defaultMainStyle;
    final currency = currencyStyle ?? defaultCurrencyStyle;

    final dOverridePrice = overridePrice ?? 0;
    final shouldOverrideWithoutLineThrough = dOverridePrice == price;

    final baseDisplayPrice =
        !shouldOverrideWithoutLineThrough ? dOverridePrice : price;

    if (shouldOverrideWithoutLineThrough) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: baseDisplayPrice.formatAsPriceForPrint(decimalDigits: 1),
              style: main,
            ),
            TextSpan(
              text: " ${context.translation!.currency}",
              style: currency,
            ),
            if (quantity != null) ...[
              TextSpan(
                text: ' x $quantity',
                style: context.responsiveTextTheme.current.bodySmall
                    .copyWith(color: Colors.grey[500]),
              ),
              TextSpan(
                text: ' ${context.translation!.qty}',
                style: context.responsiveTextTheme.current.bodyXSmall
                    .copyWith(fontSize: 8, color: Colors.grey[500]),
              ),
            ],
          ],
        ),
      );
    }

    if (!shouldOverrideWithoutLineThrough && dOverridePrice > 0) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: price.formatAsPriceForPrint(decimalDigits: 1),
                  style: line.copyWith(
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
                  text:
                      baseDisplayPrice.formatAsPriceForPrint(decimalDigits: 1),
                  style: main,
                ),
                TextSpan(
                  text: " ${context.translation!.currency}",
                  style: currency,
                ),
                if (quantity != null) ...[
                  TextSpan(
                    text: ' x $quantity',
                    style: context.responsiveTextTheme.current.bodySmall
                        .copyWith(color: Colors.grey[500]),
                  ),
                  TextSpan(
                    text: ' ${context.translation!.qty}',
                    style: context.responsiveTextTheme.current.bodyXSmall
                        .copyWith(fontSize: 8, color: Colors.grey[500]),
                  ),
                ]
              ],
            ),
          ),
        ],
      );
    }
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: price.formatAsPriceForPrint(decimalDigits: 1), style: main),
          TextSpan(text: " ${context.translation!.currency}", style: currency),
        ],
      ),
    );
  }
}
