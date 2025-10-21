import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes/routing_manager.dart';

class LocationManager {
  static final LocationManager _instance = LocationManager._internal();
  static LocationManager get instance => _instance;

  LocationManager._internal();
  Future<Position> getCurrentLocation() async {
    late Position currentLocation;
    LocationPermission value = await Geolocator.checkPermission();
    // Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude)
    if (value == LocationPermission.denied) {
      await requestLocationPermission(() async {
        await showDialog(
            context: RoutingManager.rootNavigatorKey.currentContext!,
            builder: (BuildContext context) => AlertDialog(
                    title: const Text('Location Permission Required'),
                    content: const Text(
                        'Please enable location permission in settings.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Settings'),
                        onPressed: () {
                          Geolocator.openLocationSettings();
                        },
                      ),
                    ]));
      });
      getCurrentLocation();
    } else {
      currentLocation = await Geolocator.getCurrentPosition();
    }
    return currentLocation;
  }

  Future<PermissionStatus> requestLocationPermission(
      Function? onDeniedCallbackFunc) async {
    return await Permission.location
        .onDeniedCallback(onDeniedCallbackFunc!())
        .request();
  }
}
