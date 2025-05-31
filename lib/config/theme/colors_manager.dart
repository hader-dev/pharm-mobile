import 'package:flutter/material.dart';

enum BackGroundColors {
  bgWhite(color: Color.fromARGB(255, 255, 255, 255)),
  bgDarken(color: Color.fromARGB(255, 242, 244, 247)),
  bgDarken2(color: Color.fromARGB(255, 230, 230, 230)),
  bgDisabled(color: Color.fromARGB(255, 230, 230, 230));

  final Color color;
  const BackGroundColors({this.color = Colors.transparent});
}

enum TextColors {
  primary(color: Color.fromARGB(255, 47, 47, 47)),
  secondary(color: Color.fromARGB(255, 80, 80, 80)),
  ternary(color: Color.fromARGB(255, 144, 144, 144)),
  white(color: Color.fromARGB(255, 255, 255, 255));

  final Color color;
  const TextColors({this.color = Colors.transparent});
}

enum StrokeColors {
  normal(color: Color.fromARGB(255, 47, 47, 47)),
  focused(color: Color.fromARGB(255, 22, 125, 133));

  final Color color;
  const StrokeColors({this.color = Colors.transparent});
}

enum SystemColors {
  orange(
    primary: Color.fromARGB(255, 255, 108, 61),
    secondary: Color.fromARGB(255, 255, 198, 180),
    ternary: Color.fromARGB(255, 255, 237, 232),
  ),
  yellow(
    primary: Color.fromARGB(255, 255, 184, 46),
    secondary: Color.fromARGB(255, 255, 234, 193),
    ternary: Color.fromARGB(255, 255, 248, 234),
  ),
  red(
    primary: Color.fromARGB(255, 240, 40, 73),
    secondary: Color.fromARGB(255, 245, 105, 128),
    ternary: Color.fromARGB(255, 254, 234, 237),
  ),
  green(
    primary: Color.fromARGB(255, 67, 159, 110),
    secondary: Color.fromARGB(255, 192, 236, 212),
    ternary: Color.fromARGB(255, 241, 255, 244),
  ),
  ;

  final Color primary;
  final Color secondary;
  final Color ternary;
  const SystemColors({
    this.primary = Colors.transparent,
    this.secondary = Colors.transparent,
    this.ternary = Colors.transparent,
  });
}




// class AppColorsManager {


//   backGround
//   // static const List<Color> lightAccentsColors = <Color>[
//   //   Color.fromARGB(255, 255, 255, 255),
//   //   Color.fromARGB(255, 230, 230, 230),
//   //   Color.fromARGB(255, 204, 204, 204),
//   //   Color.fromARGB(255, 179, 179, 179)
//   // ];
//   // static const List<Color> darkAccentsColors = <Color>[
//   //   Color.fromARGB(255, 0, 0, 0),
//   //   Color.fromARGB(255, 42, 42, 42),
//   //   Color.fromARGB(255, 67, 67, 67),
//   //   Color.fromARGB(255, 118, 118, 118)
//   // ];
//   // static const List<Color> primaryColors = <Color>[
//   //   Color.fromARGB(255, 81, 78, 183),
//   //   Color.fromARGB(255, 116, 113, 197),
//   //   Color.fromARGB(255, 133, 131, 205),
//   //   Color.fromARGB(255, 203, 202, 233)
//   // ];

//   // static final Color appLightBgColor = lightAccentsColors.first;
//   // static final Color appDarkBgColor = darkAccentsColors[3];

//   // static BoxShadow cardShadow = BoxShadow(
//   //     color: AppColorsManager.lightAccentsColors[2].withOpacity(.5), blurRadius: 4, blurStyle: BlurStyle.outer);

//   // static BoxDecoration cardDecoration(
//   //   Color? cardColor,
//   // ) =>
//   //     BoxDecoration(
//   //         color: cardColor ?? AppColorsManager.lightAccentsColors.first,
//   //         boxShadow: <BoxShadow>[AppColorsManager.cardShadow],
//   //         border: Border.all(
//   //           color: AppColorsManager.lightAccentsColors[1].withOpacity(.5),
//   //           width: 1,
//   //         ),
//   //         borderRadius: BorderRadius.circular(AppSizes.extraSmallRadius));
// }