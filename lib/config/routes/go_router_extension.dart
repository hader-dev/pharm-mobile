import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';

extension GoRouterExtension on GoRouter {
  void safePop() {
    if (canPop()) {
      pop();
    }
  }


  void popOrGoHome() {
    if (canPop()) {
      pop();
    } else {
      pushReplacement(RoutingManager.appLayout);
    }
  }
}
