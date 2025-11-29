import 'package:flutter/services.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

void setupStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.bgWhite,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
