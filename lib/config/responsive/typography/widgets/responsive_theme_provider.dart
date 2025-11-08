import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/light_theme.dart';

class ResponsiveThemeProvider extends StatefulWidget {
  final Widget child;
  const ResponsiveThemeProvider({super.key, required this.child});

  @override
  State<ResponsiveThemeProvider> createState() =>
      _ResponsiveThemeProviderState();
}

class _ResponsiveThemeProviderState extends State<ResponsiveThemeProvider> {
  late DeviceSizes deviceSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    deviceSize =
        DeviceSizesExtension.fromWidth(MediaQuery.of(context).size.width);
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = LightTheme(deviceSize: deviceSize);
    return Theme(data: lightTheme.theme, child: widget.child);
  }
}
