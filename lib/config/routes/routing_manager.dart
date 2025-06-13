import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/app_componants/app_componants.dart';
import '../../features/app_layout/app_layout.dart';
import '../../features/check_email/check_email.dart';
import '../../features/check_phone/check_phone.dart';
import '../../features/congratulation/congratulation.dart';
import '../../features/create_company_profile/create_company_profile.dart';
import '../../features/login/login.dart';
import '../../features/product_details/product_details.dart';
import '../../features/profile_picture_setup/profile_picture_setup.dart';
import '../../features/register/register.dart';

// import '../../view/screens/login/login.dart';
// import '../../view/screens/splash/splash.dart';

class RoutingManager {
  static List<String> screenStack = [];

  //static const String placeHolderScreenPath = '/PlaceHolderScreenPath';
  static const String appComponentsScreen = '/appComponentsScreen';
  static const String appLayout = '/AppLayout';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/RegisterScreen';
  static const String checkEmailScreen = '/CheckEmailScreen';
  static const String checkPhoneScreen = '/CheckPhoneScreen';
  static const String profilePictureSetup = '/ProfilePictureSetup';
  static const String congratulationScreen = '/CongratulationScreen';
  static const String createCompanyProfile = '/CreateCompanyProfile';
  static const String productDetailsScreen = '/ProductDetailsScreen';

  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: appLayout,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          name: appLayout,
          path: appLayout,
          builder: (BuildContext context, GoRouterState state) {
            return const AppLayout();
          },
        ),
        GoRoute(
          name: appComponentsScreen,
          path: appComponentsScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const AppComponentsScreen(
              title: "I'm the best Mobile dev ever ",
            );
          },
        ),
        GoRoute(
            name: loginScreen,
            path: loginScreen,
            builder: (BuildContext context, GoRouterState state) {
              return LoginScreen();
            }),
        GoRoute(
            name: registerScreen,
            path: registerScreen,
            builder: (BuildContext context, GoRouterState state) {
              return RegisterScreen();
            }),
        GoRoute(
            name: checkEmailScreen,
            path: checkEmailScreen,
            builder: (BuildContext context, GoRouterState state) {
              return CheckEmailScreen();
            }),
        GoRoute(
            name: checkPhoneScreen,
            path: checkPhoneScreen,
            builder: (BuildContext context, GoRouterState state) {
              return CheckPhoneScreen();
            }),
        GoRoute(
            name: profilePictureSetup,
            path: profilePictureSetup,
            builder: (BuildContext context, GoRouterState state) {
              return const ProfilePictureSetup();
            }),
        GoRoute(
            name: congratulationScreen,
            path: congratulationScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const CongratulationScreen();
            }),
        GoRoute(
            name: createCompanyProfile,
            path: createCompanyProfile,
            builder: (BuildContext context, GoRouterState state) {
              return const CreateCompanyProfile();
            }),
        GoRoute(
            name: productDetailsScreen,
            path: productDetailsScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const ProductDetailsScreen();
            }),
      ]);

  static Future<void> popUntilPath(BuildContext context, String routePath) async {
    while (GoRouter.of(context).routerDelegate.currentConfiguration.matches.last.matchedLocation != routePath) {
      debugPrint(GoRouter.of(context).routerDelegate.currentConfiguration.matches.last.matchedLocation);
      if (!context.canPop()) {
        break;
      }
      context.pop();
    }
  }
}
