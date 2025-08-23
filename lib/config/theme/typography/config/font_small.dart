import 'package:hader_pharm_mobile/config/theme/typography/app_fonts.dart';
import 'package:hader_pharm_mobile/config/theme/typography/typoghrapy_source.dart';

// Small device font sizes (mobile phones in portrait)
// Slightly smaller than base sizes for compact displays
final AppFonts appFontSmall = AppFonts(
  appFont: AppTypographySource.appFont,
  appFontBold: AppTypographySource.appFontBold,
  appFontSemiBold: AppTypographySource.appFontSemiBold,
  appFontMedium: AppTypographySource.appFontMedium,
  appFontRegular: AppTypographySource.appFontRegular,
  
  // Headings - reduced by 10-15% for small screens
  headLine1: 24.0, // was 28.0
  headLine2: 18.0, // was 20.0
  headLine3: 16.0, // was 18.0
  headLine4: 14.0, // was 16.0
  headLine5: 13.0, // was 15.0

  // Body text - reduced by 5-10% for small screens
  body1: 15.0, // was 16.0
  body2: 14.0, // was 15.0
  body3: 13.0, // was 14.0
  bodySmall: 12.0, // was 13.0
  bodyXSmall: 11.0, // was 12.0
  bodyXXSmall: 9.0, // unchanged
);
