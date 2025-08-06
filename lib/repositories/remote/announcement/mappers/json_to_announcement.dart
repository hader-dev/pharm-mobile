import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';

AnnouncementModel jsonToAnnouncement(Map<String, dynamic> json) {
  return AnnouncementModel(
    image: json['image']??"unknown",
    title: json['title']??"unknown",
    content: json['content']??"unknown",
    thumbnailImage: json['thumbnailImage']??"unknown",
  );
}

List<AnnouncementModel> jsonToAnnouncementsList(List<dynamic> json) {
  return json.map((announcement) => jsonToAnnouncement(announcement)).toList();
}


ResponseLoadAnnouncements jsonToAnnouncementsResponse(Map<String, dynamic> json) {
  final data = json['data'];
  if (data is List) {
    final announcements = data
        .map((e) => jsonToAnnouncement(e as Map<String, dynamic>))
        .toList();
    return ResponseLoadAnnouncements(announcements: announcements);
  }
  return ResponseLoadAnnouncements(announcements: []);
}