import 'package:hader_pharm_mobile/models/announcement.dart';

class ResponseLoadAnnouncements {
  List<AnnouncementModel> announcements;
  final int totalItems;
  ResponseLoadAnnouncements(
      {this.announcements = const [], this.totalItems = 0});
}
