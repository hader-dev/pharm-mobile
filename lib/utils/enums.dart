import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

// enum OrderStatus {
//   newStat(
//     id: 1,
//     color: Color.fromARGB(255, 73, 73, 73),
//     icon: Icons.new_releases,
//   ),
//   confirmed(
//     id: 2,
//     color: Colors.orange,
//     icon: Icons.play_arrow,
//   ),
//   completed(
//     id: 3,
//     color: Colors.green,
//     icon: Icons.check_circle,
//   ),
//   canceled(
//     id: 4,
//     color: Colors.red,
//     icon: Icons.cancel,
//   );

//   final int id;

//   final Color color;
//   final IconData icon;

//   const OrderStatus({
//     required this.id,
//     required this.color,
//     required this.icon,
//   });

//   static String translateLabel(BuildContext context, OrderStatus expression) {
//     return '';
//     // switch (expression) {
//     //   case OrderStatus.newStat:
//     //     return context.translation!.wait_for_approval;

//     //   case OrderStatus.confirmed:
//     //     return context.translation!.confirmed;

//     //   case OrderStatus.completed:
//     //     return context.translation!.completed;

//     //   case OrderStatus.canceled:
//     //     return context.translation!.canceled;

//     //   default:
//     //     return context.translation!.unknown;
//     // }
//   }

//   static String translateDescription(BuildContext context, OrderStatus expression) {
//     return '';
//     // switch (expression) {
//     //   case OrderStatus.newStat:
//     //     return context.translation!.wait_for_approval_desc;

//     //   case OrderStatus.confirmed:
//     //     return context.translation!.confirmed_desc;

//     //   case OrderStatus.completed:
//     //     return context.translation!.completed;

//     //   case OrderStatus.canceled:
//     //     return context.translation!.canceled_desc;

//     //   default:
//     //     return context.translation!.unknown;
//     // }
//   }
// }

enum DialogType {
  info(
    color: Colors.blue,
    icon: Icons.info_outline,
  ),
  success(
    color: Colors.green,
    icon: Icons.check_circle_outline,
  ),
  warning(
    color: Colors.orange,
    icon: Icons.warning_amber_outlined,
  ),
  error(
    color: Colors.red,
    icon: Icons.close,
  );

  final Color color;
  final IconData icon;

  const DialogType({
    required this.color,
    required this.icon,
  });
}

enum Role {
  superAdmin(1),
  admin(2),
  company(3),
  client(4);

  final int id;

  const Role(this.id);
}

enum FieldState {
  normal(color: SystemColors.defaultState),
  loading(wordKey: "Loading", color: SystemColors.defaultState),
  disabled(color: SystemColors.defaultState),
  success(wordKey: "Success", color: SystemColors.green, icon: Icons.check_circle),
  warning(wordKey: "Warning", color: SystemColors.orange, icon: Icons.warning_amber_rounded),
  error(wordKey: "Error", color: SystemColors.red, icon: Icons.error);

  final SystemColors color;
  final IconData? icon;
  final String wordKey;
  const FieldState({this.wordKey = '', required this.color, this.icon});
}
