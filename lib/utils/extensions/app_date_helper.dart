import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  String get format => DateFormat("yyyy-MM-dd").add_Hm().format(this);
  String get formatYMD => DateFormat("yyyy-MM-dd").format(this);

  String formatDMY(AppLocalizations localization) {
    final locale = localization.localeName;

    final formatter = DateFormat("d MMMM yyyy", locale);

    return formatter.format(this);
  }

  String getTimingAgo(AppLocalizations localization) {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inMinutes < 1) {
      return localization.just_now;
    }

    if (diff.inHours < 1) {
      return diff.inMinutes == 1
          ? localization.minute_ago
          : localization.minutes_ago(diff.inMinutes);
    }

    if (diff.inDays < 1) {
      return diff.inHours == 1
          ? localization.hour_ago
          : localization.hours_ago(diff.inHours);
    }

    if (diff.inDays == 1) return localization.yesterday;

    if (diff.inDays < 7) {
      return diff.inDays == 1
          ? localization.day_ago
          : localization.days_ago(diff.inDays);
    }

    if (diff.inDays < 14) return localization.last_week;

    if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return weeks == 1 ? localization.week_ago : localization.weeks_ago(weeks);
    }

    if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return months == 1
          ? localization.month_ago
          : localization.months_ago(months);
    }

    final years = (diff.inDays / 365).floor();
    return years == 1 ? localization.year_ago : localization.years_ago(years);
  }
}
