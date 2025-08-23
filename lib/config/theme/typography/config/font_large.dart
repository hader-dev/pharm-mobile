import 'package:hader_pharm_mobile/config/theme/typography/app_fonts.dart';
import 'package:hader_pharm_mobile/config/theme/typography/typoghrapy_source.dart';

// Large device font sizes (tablets and large screens)
// Increased by 15-25% for better readability on larger screens
final AppFonts appFontLarge = AppFonts(
  appFont: AppTypographySource.appFont,
  appFontBold: AppTypographySource.appFontBold,
  appFontSemiBold: AppTypographySource.appFontSemiBold,
  appFontMedium: AppTypographySource.appFontMedium,
  appFontRegular: AppTypographySource.appFontRegular,
  
  // Headings - increased by 20-25% for tablets
  headLine1: 34.0, // was 28.0 (+21%)
  headLine2: 24.0, // was 20.0 (+20%)
  headLine3: 22.0, // was 18.0 (+22%)
  headLine4: 19.0, // was 16.0 (+19%)
  headLine5: 18.0, // was 15.0 (+20%)

  // Body text - increased by 15-20% for tablets
  body1: 18.0, // was 16.0 (+12.5%)
  body2: 17.0, // was 15.0 (+13%)
  body3: 16.0, // was 14.0 (+14%)
  bodySmall: 15.0, // was 13.0 (+15%)
  bodyXSmall: 14.0, // was 12.0 (+17%)
  bodyXXSmall: 11.0, // was 9.0 (+22%)
);
