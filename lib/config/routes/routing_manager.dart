import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/app_componants/app_componants.dart';
import '../../features/login/login.dart';
import '../../features/register/register.dart';

// import '../../view/screens/login/login.dart';
// import '../../view/screens/splash/splash.dart';

class RoutingManager {
  static List<String> screenStack = [];

  //static const String placeHolderScreenPath = '/PlaceHolderScreenPath';
  static const String appComponentsScreen = '/appComponentsScreen';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/RegisterScreen';
  // static const String onboardingScreen = '/onboardingScreen';
  // static const String shopScreen = '/shopScreen';
  // static const String cartScreen = 'CartScreen';
  // static const String productDetailsScreen = '/ProductDetailsScreen';
  // static const String productPicturesView = '/ProductPicturesView';
  // static const String searchScreen = '/searchScreen';
  // static const String myOrdersScreen = '/myOrdersScreen';
  // static const String trackOrderScreen = '/trackOrderScreen';
  // static const String checkOutScreen = 'CheckOutScreen';
  // static const String locationSelectionScreen = '/locationSelectionScreen';
  // static const String mapSelectionScreen = '/mapSelectionScreen';
  // static const String notificationScreen = '/NotificationScreen';
  // static const String helpCenterScreen = '/helpCenterScreen';
  // static const String settingsScreen = '/settingsScreen';
  // static const String legalPoliciesScreen = '/legalPoliciesScreen';
  // static const String languageScreen = '/LanguageScreen';
  // static const String changePasswordScreen = '/ChangePasswordScreen';
  // static const String addNewPaymentCardScreen = '/AddNewPaymentCardScreen';
  // static const String editProfileScreen = '/EditProfileScreen';
  // static const String notificationSettingsScreen = '/NotificationSettingsScreen';
  // static const String homeScreen = '/homeScreen';
  // static const String profileScreen = '/ProfileScreen';
  // static const String orderDetailsScreen = '/orderDetailsScreen';
  // static const String searchFilterPage = '/searchFilterPage';
  // static const String supCategories = '/supCategories';

  // static const String subBrandsLayout = '/subBrandsLayout';

  // static const String supBrands = '/SupBrands';

  // static const String allCategories = '/AllCategories';
  // static const String allBrands = '/allBrands';
  // static const String screenAllProducts = '/screenAllProducts';

  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  // static List<int> listIdScreenBrand = [];
  // static List<int> listIdScreenCategory = [];

  static final GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: registerScreen,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
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
      ]);
  //     GoRoute(
  //         name: homeScreen,
  //         path: homeScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const HomeScreen();
  //         },
  //         routes: <RouteBase>[
  //           GoRoute(
  //               name: cartScreen,
  //               path: cartScreen,
  //               builder: (BuildContext context, GoRouterState state) {
  //                 return const CartScreen();
  //               }),
  //           GoRoute(
  //             path: checkOutScreen,
  //             name: checkOutScreen,
  //             builder: (BuildContext context, GoRouterState state) =>
  //                 CheckOutScreen(
  //               cartItems: state.extra as List<CartItemModel>,
  //             ),
  //           ),
  //         ]),
  //     GoRoute(
  //       name: orderDetailsScreen,
  //       path: orderDetailsScreen,
  //       builder: (BuildContext context, GoRouterState state) {
  //         return OrderDetailsScreen(orderId: state.extra as int);
  //       },
  //     ),
  //     GoRoute(
  //         name: profileScreen,
  //         path: profileScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return ProfileScreen(openedFrom: state.extra as String);
  //         }),
  //     GoRoute(
  //         name: splashScreen,
  //         path: splashScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const SplashScreen();
  //         }),
  //     GoRoute(
  //         name: onboardingScreen,
  //         path: onboardingScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const OnboardingScreen();
  //         }),

  //     GoRoute(
  //         name: notificationSettingsScreen,
  //         path: notificationSettingsScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const NotificationSettingsScreen();
  //         }),
  //     GoRoute(
  //         name: editProfileScreen,
  //         path: editProfileScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const EditProfileScreen();
  //         }),
  //     GoRoute(
  //         name: addNewPaymentCardScreen,
  //         path: addNewPaymentCardScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const AddNewPaymentCardScreen();
  //         }),
  //     GoRoute(
  //         name: changePasswordScreen,
  //         path: changePasswordScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const ChangePasswordScreen();
  //         }),
  //     GoRoute(
  //         name: languageScreen,
  //         path: languageScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const LanguagesScreen();
  //         }),
  //     GoRoute(
  //         name: legalPoliciesScreen,
  //         path: legalPoliciesScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const LegalPoliciesScreen();
  //         }),
  //     GoRoute(
  //         name: helpCenterScreen,
  //         path: helpCenterScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const HelpCenterScreen();
  //         }),
  //     GoRoute(
  //         name: trackOrderScreen,
  //         path: trackOrderScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const TrackOrderScreen();
  //         }),
  //     GoRoute(
  //         name: myOrdersScreen,
  //         path: myOrdersScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const MyOrdersScreen();
  //         }),
  //     GoRoute(
  //         name: productDetailsScreen,
  //         path: productDetailsScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return ProductDetailsScreen(productId: state.extra as int);
  //         }),
  //     GoRoute(
  //         name: shopScreen,
  //         path: shopScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const ShopScreen();
  //         }),

  //     GoRoute(
  //       path: productPicturesView,
  //       name: productPicturesView,
  //       builder: (BuildContext context, GoRouterState state) =>
  //           ProductInteractivePictures(
  //               pictures: state.extra as List<ArticleGallery>),
  //     ),
  //     GoRoute(
  //       path: searchScreen,
  //       name: searchScreen,
  //       builder: (BuildContext context, GoRouterState state) =>
  //           const SearchScreen(),
  //     ),

  //     GoRoute(
  //       path: locationSelectionScreen,
  //       name: locationSelectionScreen,
  //       builder: (BuildContext context, GoRouterState state) =>
  //           LocationSelectionScreen(
  //         addressId: state.extra as int? ?? -1,
  //       ),
  //     ),
  //     GoRoute(
  //       path: mapSelectionScreen,
  //       name: mapSelectionScreen,
  //       builder: (BuildContext context, GoRouterState state) =>
  //           const MapSection(),
  //     ),
  //     GoRoute(
  //       name: notificationScreen,
  //       path: notificationScreen,
  //       builder: (BuildContext context, GoRouterState state) {
  //         return const NotificationScreen();
  //       },
  //     ),
  //     GoRoute(
  //         name: settingsScreen,
  //         path: settingsScreen,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const SettingsScreen();
  //         }),
  //     GoRoute(
  //       name: supCategories,
  //       path: supCategories,
  //       builder: (BuildContext context, GoRouterState state) {
  //         final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
  //         final title = state.uri.queryParameters['title'];

  //         return SupCategories(
  //           categoryId: state.extra as int,
  //           title: state.uri.queryParameters['title'],
  //         );
  //       },
  //     ),

  //     GoRoute(
  //         name: allCategories,
  //         path: allCategories,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const AllCategories();
  //         }),
  //     GoRoute(
  //         name: allBrands,
  //         path: allBrands,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return const AllBrands();
  //         }),
  //     GoRoute(
  //         name: subBrandsLayout,
  //         path: subBrandsLayout,
  //         builder: (BuildContext context, GoRouterState state) {
  //           return SubBrandsLayout(firstBrandId: state.extra as int);
  //         }),
  //     GoRoute(
  //       name: screenAllProducts,
  //       path: screenAllProducts,
  //       builder: (BuildContext context, GoRouterState state) {
  //         return const ScreenAllProducts();
  //       },
  //     )
  //     // GoRoute(
  //     //     name: searchFilterPage,
  //     //     path: searchFilterPage,
  //     //     builder: (context, state) {
  //     //       return SearchFilterPage(
  //     //         cubit: state.extra as SearchCubit,
  //     //       );
  //     //     }),
  //   ],
  // );

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
