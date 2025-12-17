import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_marketplace/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_marketplace/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_marketplace/widgets/body.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_marketplace/widgets/nav_bar.dart';
import 'package:hader_pharm_mobile/models/client.dart';

class DeligateMarketPlaceScreen extends StatelessWidget {
  static final marketPlaceScaffoldKey = GlobalKey<ScaffoldState>();
  const DeligateMarketPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();

    //  DeligateMarketPlaceStateProvider(
    //   client: GoRouterState.of(context).extra as DeligateClient,
    //   child: SafeArea(
    //     child: Scaffold(
    //       key: marketPlaceScaffoldKey,
    //       body: Column(
    //         children: [
    //           DeligateMarketplaceAppbar(),
    //           const DeligateMarketPlaceBody(),
    //         ],
    //       ),
    //       bottomNavigationBar: const DeligateMarketplaceNavBar(),
    //     ),
    //   ),
    // );
  }
}
