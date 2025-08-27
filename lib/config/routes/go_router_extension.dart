import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';

extension GoRouterExtension on GoRouter {
  void safePop<T extends Object?>([T? result])  {
    if (canPop()) {
      pop(result);
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
