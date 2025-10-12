import 'package:firebase_messaging/firebase_messaging.dart';

import 'mock_notification_model.dart';

RemoteMessage mockRemoteMessage() {
  return RemoteMessage(
    senderId: 'mockSenderId',
    category: 'mockCategory',
    collapseKey: 'mockCollapseKey',
    contentAvailable: true,
    data: mockNotificationModelAsJson(),
    from: 'mockFrom',
    messageId: 'mockMessageId',
    messageType: 'mockMessageType',
    mutableContent: true,
    notification: RemoteNotification(
      title: 'Mock Title',
      body: 'Mock body text',
      android: AndroidNotification(
        channelId: 'mock_channel_id',
        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
      ),
      apple: AppleNotification(
        subtitle: 'Mock subtitle',
      ),
    ),
    sentTime: DateTime.now(),
    threadId: 'mockThreadId',
    ttl: 3600,
  );
}
