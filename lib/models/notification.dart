class NotificationModel {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final String type;
  final DateTime createdAt;
  final String? clientId;
  final String? redirectUrl;
  final dynamic actionPayload;

  NotificationModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.isRead,
      required this.type,
      required this.createdAt,
      this.clientId,
      this.redirectUrl,
      this.actionPayload});

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    bool? isRead,
    String? type,
    DateTime? createdAt,
    String? clientId,
    String? redirectUrl,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      clientId: clientId ?? this.clientId,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      actionPayload: actionPayload,
    );
  }
}

enum NotificationType { order, claim, announcement }

extension NotificationTypeExtension on NotificationType {
  static NotificationType fromString(String type) {
    final parsedType = type.split('.').first;
    switch (parsedType) {
      case 'order':
        return NotificationType.order;
      case 'claim':
        return NotificationType.claim;
      case 'announcement':
        return NotificationType.announcement;
      default:
        throw Exception('Unknown notification type: $type');
    }
  }

  String toShortString() {
    return toString().split('.').last;
  }
}
