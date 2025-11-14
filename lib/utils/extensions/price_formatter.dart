import 'package:intl/intl.dart';

extension PriceFormatter on double {
  String formatAsPrice() {
    final NumberFormat priceFormat = NumberFormat.currency(
      decimalDigits: 2,
      symbol: '',
    );

    return priceFormat.format(this);
  }

  String formatAsPriceForPrint({int decimalDigits = 2}) {
    final NumberFormat priceFormat = NumberFormat.currency(
      locale: 'en',
      decimalDigits: decimalDigits,
      symbol: '',
    );

    return priceFormat.format(this).replaceAll(',', ' ');
  }

  String formatAsPercentage({int decimalDigits = 2}) {
    final NumberFormat percentFormat = NumberFormat.percentPattern('en')
      ..minimumFractionDigits = decimalDigits
      ..maximumFractionDigits = decimalDigits;

    return percentFormat.format(this);
  }
}
