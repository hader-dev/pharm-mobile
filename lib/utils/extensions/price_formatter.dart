import 'package:intl/intl.dart';

extension PriceFormatter on double {
  String formatAsPrice() {
    final NumberFormat priceFormat = NumberFormat.currency(
      decimalDigits: 2,
      symbol: '',
    );

    return priceFormat.format(this);
  }

  String formatAsPriceForPrint() {
    final NumberFormat priceFormat = NumberFormat.currency(
      locale: 'en',
      decimalDigits: 2,
      symbol: '',
    );

    return priceFormat.format(this).replaceAll(',', ' ');
  }
}
