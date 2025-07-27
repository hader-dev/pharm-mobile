import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  String get format => DateFormat("yyyy-MM-dd").add_Hm().format(this);
  String get formatYMD => DateFormat("yyyy-MM-dd").format(this);

  String getTimingAgo() {
    final DateTime now = DateTime.now();
    // ignore: unused_local_variable
    final Duration diff = now.difference(this);
    return '';
    //   if (diff.inMinutes < 1) {
    //     return localization.just_now;
    //   } else if (diff.inHours < 1) {
    //     return diff.inMinutes > 1 ? localization.minutes_ago(diff.inMinutes) : localization.minute_ago;
    //   } else if (diff.inDays < 1) {
    //     return diff.inHours > 1 ? localization.hours_ago(diff.inHours) : localization.hour_ago;
    //   } else if (diff.inDays == 1) {
    //     return localization.yesterday;
    //   } else if (diff.inDays < 7) {
    //     return diff.inDays > 1 ? localization.days_ago(diff.inDays) : localization.day_ago;
    //   } else if (diff.inDays < 14) {
    //     return localization.last_week;
    //   } else if (diff.inDays < 30) {
    //     return (diff.inDays / 7).floor() > 1 ? localization.weeks_ago((diff.inDays / 7).floor()) : localization.week_ago;
    //   } else if (diff.inDays < 365) {
    //     return (diff.inDays / 30).floor() > 1
    //         ? localization.months_ago((diff.inDays / 30).floor())
    //         : localization.month_ago;
    //   } else {
    //     final years = (diff.inDays / 365).floor();
    //     return years > 1 ? localization.years_ago(years) : localization.year_ago;
    //   }
    // }
  }
}
