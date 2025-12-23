import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/deeplinks_routes.dart';
import 'package:hader_pharm_mobile/features/app_componants/app_componants.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/announcements/all_announcements_screen.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/announcement_details.dart';
import 'package:hader_pharm_mobile/features/common_features/change_password/change_password.dart';
import 'package:hader_pharm_mobile/features/common_features/check_email/check_email.dart';
import 'package:hader_pharm_mobile/features/common_features/check_phone/check_phone.dart';
import 'package:hader_pharm_mobile/features/common_features/congratulation/congratulation.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/create_company_profile.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_create_client/deligate_create_client.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_create_order/deligate_create_order.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_marketplace/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/edit_company_screen.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_profile/edit_profile.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/favorites.dart';
import 'package:hader_pharm_mobile/features/common_features/help_support/help_support.dart';
import 'package:hader_pharm_mobile/features/common_features/invoice/invoice.dart';
import 'package:hader_pharm_mobile/features/common_features/language/lang_screen.dart';
import 'package:hader_pharm_mobile/features/common_features/leagal_policies/leagal_policies.dart';
import 'package:hader_pharm_mobile/features/common_features/login/login.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/medicine_catalog_details_client.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/medicine_catalog_details_deligate.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/notification.dart';
import 'package:hader_pharm_mobile/features/common_features/onboarding/onboarding.dart' show OnboardingScreen;
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/complaint.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/orders.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/orders_details.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/para_pharma_catalog_details_client.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/para_pharma_catalog_details_deligate.dart';
import 'package:hader_pharm_mobile/features/common_features/profile/profile.dart';
import 'package:hader_pharm_mobile/features/common_features/register/register.dart';
import 'package:hader_pharm_mobile/features/common_features/splash/splash.dart';
import 'package:hader_pharm_mobile/features/common_features/vendor_details/vendor_details.dart';

import '../../features/delegate/delegate_orders_details/delegate_orders_details.dart' show DelegateOrdersDetailsScreen;

class RoutingManager {
  static List<String> screenStack = [];

  //static const String placeHolderScreenPath = '/PlaceHolderScreenPath';
  static const String appComponentsScreen = '/appComponentsScreen';
  static const String appLayout = '/AppLayout';
  static const String splashScreen = '/SplashScreen';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/RegisterScreen';
  static const String checkEmailScreen = '/CheckEmailScreen';
  static const String checkPhoneScreen = '/CheckPhoneScreen';
  static const String legalPoliciesScreen = '/LegalPoliciesScreen';
  static const String invoiceScreen = '/InvoiceScreen';

  static const String congratulationScreen = '/CongratulationScreen';
  static const String createCompanyProfile = '/CreateCompanyProfile';
  static const String medicineDetailsScreen = '/MedicineDetailsScreen';
  static const String paraPharmaDetailsScreen = '/ParaPharmaDetailsScreen';
  static const String ordersScreen = '/OrdersScreen';

  static const String deligateOrderDetailsScreen = '/DeligateOrderDetailsScreen';

  static const String onboardingScreen = '/OnboardingScreen';
  static const String profileScreen = '/ProfileScreen';
  static const String changePasswordScreen = 'ChangePasswordScreen';
  static const String favoritesScreen = 'FavoritesScreen';
  static const String vendorDetails = '/VendorDetails';
  static const String ordersDetailsScreen = '/OrdersDetailsScreen';
  static const String delegateOrderDetailsScreen = '/DelegateOrderDetailsScreen';
  static const String announcementDetailsScreen = '/AnnouncementDetailsScreen';
  static const String allAnnouncementsScreen = '/AllAnnouncementsScreen';
  static const String orderComplaint = '/OrderComplaint';
  static const String helpSupportScreen = '/HelpSupportScreen';

  static const String editProfileScreen = '/EditProfileScreen';
  static const String editCompanyScreen = '/EditCompanyScreen';
  static const String notificationsScreen = '/Notifications';
  static const String deligateCreateOrderScreen = '/Deligate/CreateOrder';

  static const String delegateCreateClientScreen = '/Deligate/CreateClient';
  static const String delegateMarketPlaceScreen = '/Deligate/MarketPlace';
  static const String deligateParapharmDetailsScreen = '/Deligate/ParaPharmaDetailsScreen';
  static const String deligateMedicineDetailsScreen = '/Deligate/MedicineDetailsScreen';

  static const String languagesScreen = '/LanguagesScreen';

  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: splashScreen,
      redirect: (context, state) {
        return null;
      },
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          name: deligateParapharmDetailsScreen,
          path: deligateParapharmDetailsScreen,
          builder: (BuildContext context, GoRouterState state) {
            final params = state.extra as Map<String, dynamic>;
            final id = params["id"] as String;
            final canOrder = params["canOrder"] as bool;
            final buyerCompanyId = params["buyerCompanyId"] as String;
            return DeligateParaPharmaCatalogDetailsScreen(
                paraPharmaCatalogId: id, canOrder: canOrder, buyerCompanyId: buyerCompanyId);
          },
        ),
        GoRoute(
          path: deligateMedicineDetailsScreen,
          name: deligateMedicineDetailsScreen,
          builder: (BuildContext context, GoRouterState state) {
            final params = state.extra as Map<String, dynamic>;

            final canOrder = params["canOrder"] as bool;
            final buyerCompanyId = params["buyerCompanyId"] as String;
            final medicineId = params["id"] as String;

            return MedicineCatalogDetailsDeligateScreen(
              medicineCatalogId: medicineId,
              buyerCompanyId: buyerCompanyId,
              canOrder: canOrder,
            );
          },
        ),
        GoRoute(
          name: delegateMarketPlaceScreen,
          path: delegateMarketPlaceScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const DeligateMarketPlaceScreen();
          },
        ),
        GoRoute(
          name: onboardingScreen,
          path: onboardingScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const OnboardingScreen();
          },
        ),
        GoRoute(
          name: legalPoliciesScreen,
          path: legalPoliciesScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const LegalPoliciesScreen();
          },
        ),
        GoRoute(
          name: delegateCreateClientScreen,
          path: delegateCreateClientScreen,
          builder: (BuildContext context, GoRouterState state) {
            return DelegateCreateClientScreen();
          },
        ),
        GoRoute(
          name: deligateCreateOrderScreen,
          path: deligateCreateOrderScreen,
          builder: (BuildContext context, GoRouterState state) {
            return DeligateCreateOrderScreen();
          },
        ),
        GoRoute(
          name: invoiceScreen,
          path: invoiceScreen,
          builder: (BuildContext context, GoRouterState state) {
            return InvoiceGenerator(
              invoiceId: state.extra as String,
            );
          },
        ),
        GoRoute(
          name: languagesScreen,
          path: languagesScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const LanguagesScreen();
          },
        ),
        GoRoute(
          name: helpSupportScreen,
          path: helpSupportScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const HelpAndSupportScreen();
          },
        ),
        GoRoute(
          name: notificationsScreen,
          path: notificationsScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const NotificaitonScreen();
          },
        ),
        GoRoute(
          name: splashScreen,
          path: splashScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          name: appLayout,
          path: appLayout,
          builder: (BuildContext context, GoRouterState state) {
            return const AppLayout();
          },
        ),
        GoRoute(
          name: announcementDetailsScreen,
          path: announcementDetailsScreen,
          builder: (BuildContext context, GoRouterState state) {
            return AnnouncementDetailsScreen(
              announcementId: state.extra as String,
            );
          },
        ),
        GoRoute(
          name: allAnnouncementsScreen,
          path: allAnnouncementsScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const AllAnnouncementsScreen();
          },
        ),
        GoRoute(
          name: editProfileScreen,
          path: editProfileScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const EditProfileScreen();
          },
        ),
        GoRoute(
          name: editCompanyScreen,
          path: editCompanyScreen,
          builder: (BuildContext context, GoRouterState state) {
            // Check if mode is passed as extra parameter
            final mode = state.extra as CompanyScreenMode?;
            return CompanyEditScreen(initialMode: mode);
          },
        ),
        GoRoute(
          name: ordersDetailsScreen,
          path: ordersDetailsScreen,
          builder: (BuildContext context, GoRouterState state) {
            return OrdersDetailsScreen(
              orderId: state.extra as String,
            );
          },
        ),
        GoRoute(
          name: delegateOrderDetailsScreen,
          path: delegateOrderDetailsScreen,
          builder: (BuildContext context, GoRouterState state) {
            return DelegateOrdersDetailsScreen(
              orderId: state.extra as String,
            );
          },
        ),
        GoRoute(
          name: vendorDetails,
          path: vendorDetails,
          builder: (BuildContext context, GoRouterState state) {
            return VendorDetails(
              companyId: state.extra as String,
            );
          },
        ),
        GoRoute(
          name: profileScreen,
          path: profileScreen,
          routes: [
            GoRoute(
              name: changePasswordScreen,
              path: changePasswordScreen,
              builder: (BuildContext context, GoRouterState state) {
                return const ChangePasswordScreen();
              },
            ),
            GoRoute(
              name: favoritesScreen,
              path: favoritesScreen,
              builder: (BuildContext context, GoRouterState state) {
                return const FavoritesScreen();
              },
            ),
          ],
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileScreen(
              openedFrom: "",
            );
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
          name: orderComplaint,
          path: orderComplaint,
          builder: (BuildContext context, GoRouterState state) {
            Map<String, dynamic> params = state.extra as Map<String, dynamic>;

            return OrderItemComplaintScreen(
              orderId: params["orderId"] ?? "",
              itemId: params["itemId"] ?? "",
              complaintId: params["complaintId"] ?? "",
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
              final token = state.uri.queryParameters['token'];
              return RegisterScreen(
                token: token,
              );
            }),
        GoRoute(
            name: checkEmailScreen,
            path: checkEmailScreen,
            builder: (BuildContext context, GoRouterState state) {
              Map<String, dynamic> prams = state.extra as Map<String, dynamic>;
              return CheckEmailScreen(
                email: prams["email"],
                autoRedirect: prams["autoRedirect"] ?? false,
                redirectTo: prams["redirectTo"] ?? RoutingManager.congratulationScreen,
                popInsteadOfPushReplacement: prams["popInsteadOfPushReplacement"] ?? false,
              );
            }),
        GoRoute(
            name: checkPhoneScreen,
            path: checkPhoneScreen,
            builder: (BuildContext context, GoRouterState state) {
              return CheckPhoneScreen();
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
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const CreateCompanyProfile(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
            name: medicineDetailsScreen,
            path: medicineDetailsScreen,
            builder: (BuildContext context, GoRouterState state) {
              final params = state.extra as Map<String, dynamic>;

              final canOrder = params["canOrder"] as bool;
              final id = params["id"] as String;

              return MedicineCatalogDetailsClientScreen(
                medicineCatalogId: id,
                canOrder: canOrder,
              );
            }),
        GoRoute(
            name: paraPharmaDetailsScreen,
            path: paraPharmaDetailsScreen,
            builder: (BuildContext context, GoRouterState state) {
              final params = state.extra as Map<String, dynamic>;
              final id = params["id"] as String;
              final canOrder = params["canOrder"] as bool;
              return ClientParaPharmaCatalogDetailsScreen(paraPharmaCatalogId: id, canOrder: canOrder);
            }),
        GoRoute(
            name: ordersScreen,
            path: ordersScreen,
            builder: (BuildContext context, GoRouterState state) {
              return OrdersScreen();
            }),
        ...DeeplinksRoutes.deppLinkRoutes
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
