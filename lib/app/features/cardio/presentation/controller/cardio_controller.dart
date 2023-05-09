import 'dart:async';
import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/infra/dtos/user_dto.dart';
import '../../domain/entities/health_entity.dart';
import '../../domain/usecases/health_usecase.dart';
import '../../domain/usecases/latlong_usecase.dart';

class CardioController with ChangeNotifier {
  final HealthUsecase _healthUsecase;
  final LatLongUsecase _latLongUsecase;
  late final ValueNotifier<int> _heartRate = ValueNotifier(0);
  late final ValueNotifier<int> _bloodOxygen = ValueNotifier(0);
  late Position? _position;
  late Timer? _timer;

  CardioController(
    this._healthUsecase,
    this._latLongUsecase,
  );

  Future<void> fetchInfos() async {
    final prefs = await SharedPreferences.getInstance();
    final user =
        UserDto.fromMap(json.decode(prefs.getString('user')!)).toEntity();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      _heartRate.value = faker.randomGenerator.integer(100, min: 60);
      _bloodOxygen.value = faker.randomGenerator.integer(100, min: 90);
      _position = await Geolocator.getCurrentPosition();
      _healthUsecase.call(
        HealthEntity(
          userId: user.id,
          spo2: _bloodOxygen.value,
          bpm: _heartRate.value,
          exercise: 'bicycle',
        ),
      );
      _latLongUsecase.call(
        user.id,
        position?.latitude ?? 0,
        position?.longitude ?? 0,
      );
      notifyListeners();
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }

  ValueNotifier<int> get heartRate => _heartRate;

  ValueNotifier<int> get bloodOxygen => _bloodOxygen;

  Position? get position => _position;
}
