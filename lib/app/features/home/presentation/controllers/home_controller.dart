import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health/health.dart';

class HomeController extends ChangeNotifier {
  Future<void> requestPermissions() async {
    try {
      await Geolocator.requestPermission();
      HealthFactory health = HealthFactory();
      final types = [
        HealthDataType.WEIGHT,
        HealthDataType.STEPS,
        HealthDataType.HEIGHT,
        HealthDataType.BLOOD_GLUCOSE,
        HealthDataType.WORKOUT,
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      ];
      final permissions =
          types.map((e) => HealthDataAccess.READ_WRITE).toList();

      bool? hasPermissions = await health.hasPermissions(
        types,
        permissions: permissions,
      );

      hasPermissions = false;

      bool authorized = false;
      if (!hasPermissions) {
        authorized =
            await health.requestAuthorization(types, permissions: permissions);
        debugPrint(authorized.toString());
      }
    } catch (error) {
      debugPrint("Exception in authorize: $error");
    }
  }
}
