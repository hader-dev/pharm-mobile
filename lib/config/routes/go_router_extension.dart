import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  void safePop() {
    if (canPop()) {
      pop();
    }
  }
}
