import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_unread_count.dart';

ResponseUnreadCount jsonToUnreadCount(Map<String, dynamic> json) {
  return ResponseUnreadCount(
    unreadCount: json['unreadCount'] as int,
  );
}
