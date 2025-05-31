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
}
