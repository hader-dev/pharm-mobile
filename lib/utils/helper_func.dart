// //get text lines length
// import 'package:cri/config/routes/routing_manager.dart';
// import 'package:cri/utils/enums.dart';
// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

int calculateNumberOfLines(String text, TextStyle style, double maxWidth) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: null,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);
  int textLength = textPainter.computeLineMetrics().length;
  return textLength;
}

int calculateProductStockQty(int actualQty, int reservedQty) {
  return actualQty - reservedQty;
}

// List<UserPrivilege> getRolesUnderCurrentPrivilege(int roleId) {
//   UserPrivilege selectedUserPrivilege = UserPrivilege.values.where((element) => element.id == roleId).first;
//   List<UserPrivilege> options = [];
//   switch (selectedUserPrivilege) {
//     case UserPrivilege.superAdmin:
//       options = [
//         UserPrivilege.admin,
//         UserPrivilege.annexDirector,
//         UserPrivilege.commercialManager,
//         UserPrivilege.delegate,
//         UserPrivilege.operator
//       ];
//       break;
//     case UserPrivilege.admin:
//       options = [
//         UserPrivilege.delegate,
//         UserPrivilege.annexDirector,
//         UserPrivilege.commercialManager,
//         UserPrivilege.operator
//       ];
//       break;
//     case UserPrivilege.annexDirector:
//       options = [UserPrivilege.commercialManager, UserPrivilege.delegate, UserPrivilege.operator];
//       break;
//     case UserPrivilege.commercialManager:
//       options = [UserPrivilege.operator];
//       break;
//     default:
//   }
//   return options;
// }

// /// When a notification is tapped and the app is closed , this function is called with the notification's data.
// /// If the notification is a multi-item notification, then it redirects to the
// /// [NotificationMultiDataRedirectScreen] with the items' IDs and the entity.
// /// If the notification is a single-item notification, then it redirects to the
// /// [MissionDetailsScreen] or [TaskDetailsScreen] with the item's ID.
// /// If the notification is not a mission or task, then it redirects to the
// /// [AppLayoutScreen].
// ///
// void onNotificationTappedRedirect(
//   Map<String, dynamic> notificationData,
// ) async {
//   List listItems = notificationData['ids'];
//   debugPrint(listItems.toString());

//   if (listItems.length > 1) {
//     RoutingManager.router.pushNamed(RoutingManager.notificationMultiDataRedirectScreen, extra: {
//       'entity': notificationData['entity'],
//       'ids': listItems,
//       'companyId': notificationData['companyId'],
//       'annexId': notificationData['annexId'],
//     });
//   } else {
//     switch (notificationData['entity']) {
//       case 'mission':
//         RoutingManager.router.pushNamed(RoutingManager.missionDetailsScreen, extra: listItems[0]);
//         break;

//       case 'task':
//         RoutingManager.router.pushNamed(RoutingManager.taskDetailsScreen, extra: listItems[0]);
//         break;

//       default:
//         RoutingManager.router.pushNamed(RoutingManager.appLayoutScreen);
//     }
//   }
// }
