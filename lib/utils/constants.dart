import 'package:flutter/material.dart';

/// this colors inspired from "https://colorhunt.co/palette/ecfcffb2fcff5edfff3e64ff".
class AppColorsPallette {
  static const List<Color> lightAccentsColors = <Color>[
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 230, 230, 230),
    Color.fromARGB(255, 204, 204, 204),
    Color.fromARGB(255, 179, 179, 179)
  ];
  static const List<Color> darkAccentsColors = <Color>[
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 42, 42, 42),
    Color.fromARGB(255, 67, 67, 67),
    Color.fromARGB(255, 118, 118, 118)
  ];
  static const List<Color> primaryColors = <Color>[
    Color.fromARGB(255, 81, 78, 183),
    Color.fromARGB(255, 116, 113, 197),
    Color.fromARGB(255, 133, 131, 205),
    Color.fromARGB(255, 203, 202, 233)
  ];

  static final Color appLightBgColor = lightAccentsColors.first;
  static final Color appDarkBgColor = darkAccentsColors[3];

  static BoxShadow cardShadow = BoxShadow(
      color: AppColorsPallette.lightAccentsColors[2].withOpacity(.5),
      blurRadius: 4,
      blurStyle: BlurStyle.outer);

  static BoxDecoration cardDecoration(
    Color? cardColor,
  ) =>
      BoxDecoration(
          color: cardColor ?? AppColorsPallette.lightAccentsColors.first,
          boxShadow: <BoxShadow>[AppColorsPallette.cardShadow],
          border: Border.all(
            color: AppColorsPallette.lightAccentsColors[1].withOpacity(.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppSizes.extraSmallRadius));
}

class AppTypography {
  //Fonts
  static const String appFont = "Satoshi";

  //Font Weights
  static const FontWeight appFontBold = FontWeight.bold;
  static const FontWeight appFontSemiBold = FontWeight.w600;
  static const FontWeight appFontMedium = FontWeight.w500;
  static const FontWeight appFontRegular = FontWeight.w400;

  //Font Sizes
  static const double appFontSize0 = 26.0;
  static const double appFontSize1 = 23.0;
  static const double appFontSize2 = 19.0;
  static const double appFontSize3 = 16.0;
  static const double appFontSize4 = 14.0;
  static const double appFontSize5 = 12.0;
  static const double appFontSize6 = 10.0;
  static const double appFontSize7 = 8.0;
}

class AppSizes {
  //padding
  static const double extraSmallPadding = 4;
  static const double smallPadding = 8;
  static const double smallToMediumPadding = 12;

  static const double mediumPadding = 16;
  static const double mediumToLargePadding = 24;
  static const double largePadding = 32;
  static const double largeToExtraLargePadding = 50;
  static const double extraLargePadding = 64;
  //spacing
  static const double extraSmallSpacing = 4;
  static const double smallSpacing = 8;
  static const double mediumSpacing = 16;
  static const double mediumToLargeSpacing = 24;
  static const double largeSpacing = 32;
  static const double extraLargeSpacing = 48;
  //radius
  static const double tinyRadius = 5;
  static const double extraSmallRadius = 10;
  static const double extraSmallToSmallRadius = 15;
  static const double smallRadius = 20;
  static const double smallToMediumRadius = 30;
  static const double mediumRadius = 40;
  static const double mediumToLargeRadius = 50;
  static const double largeRadius = 60;
  static const double extraLargeRadius = 80;
  //icon Size:
  static const double extraSmallIconSize = 10;
  static const double smallIconSize = 14;
  static const double smallToMediumIconSize = 16;
  static const double mediumIconSize = 20;
  static const double halfMediumIconSize = 25;
  static const double largeIconSize = 30;
  //common button
  static const double buttonHeight = 50;
}
