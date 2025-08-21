import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/light_theme.dart';

class ResponsiveThemeProvider extends StatelessWidget {
  final Widget child;

  const ResponsiveThemeProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    DeviceSizes deviceSize = DeviceSizesExtension.fromWidth(size.width);

    if (orientation == Orientation.landscape &&
        size.width >= DeviceSizes.smallTablet.width) {
      deviceSize = DeviceSizes.largeTablet;
    }

    final lightTheme = LightTheme(deviceSize: deviceSize);

    return Theme(
      data: lightTheme.theme,
      child: child,
    );
  }
}
