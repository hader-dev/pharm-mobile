class NotificationModel {
  final int id;
  final String title;
  final String body;
  final bool isRead;
  final String type;
  final DateTime createdAt;
  final int? clientId;
  final String redirectUrl;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.type,
    required this.createdAt,
    this.clientId,
    required this.redirectUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      isRead: json['isRead'] as bool,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      clientId: json['clientId'] != null ? json['clientId'] as int : null,
      redirectUrl: json['redirectUrl'] as String,
    );
  }

  NotificationModel copyWith({
    int? id,
    String? title,
    String? body,
    bool? isRead,
    String? type,
    DateTime? createdAt,
    int? clientId,
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
    );
  }
}
