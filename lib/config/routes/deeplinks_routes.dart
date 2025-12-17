import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/medicine_catalog_details_client.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/orders_details.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/para_pharma_catalog_details_client.dart';
import 'package:hader_pharm_mobile/features/common_features/register/register.dart';

abstract class DeeplinksRoutes {
  static const String deepLinkOrderDetails = '/order';
  static const String deepLinkMedicineDetails = '/product/medicine';
  static const String deepLinkParaPharmaDetails = '/product/parapharma';
  static const String deepLinkSignup = '/signup';

  static final deppLinkRoutes = [
    GoRoute(
      name: deepLinkOrderDetails,
      path: deepLinkOrderDetails,
      builder: (BuildContext context, GoRouterState state) {
        final orderId =
            (state.uri.queryParameters['orderId'] ?? state.extra) as String;
        return OrdersDetailsScreen(
          orderId: orderId,
        );
      },
    ),
    GoRoute(
      name: deepLinkMedicineDetails,
      path: '$deepLinkMedicineDetails/:productId',
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['productId']!;

        return MedicineCatalogDetailsClientScreen(
          medicineCatalogId: productId,
          canOrder: true,
        );
      },
    ),
    GoRoute(
      name: deepLinkParaPharmaDetails,
      path: '$deepLinkParaPharmaDetails/:productId',
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['productId']!;

        return ClientParaPharmaCatalogDetailsScreen(
          paraPharmaCatalogId: productId,
          canOrder: true,
        );
      },
    ),
    GoRoute(
        name: deepLinkSignup,
        path: deepLinkSignup,
        builder: (BuildContext context, GoRouterState state) {
          final token = state.uri.queryParameters['token'];
          return RegisterScreen(
            token: token,
          );
        }),
  ];
}
