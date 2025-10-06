import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';

void handleNavigateBack(BuildContext context){
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(RoutingManager.appLayout);
  }
}