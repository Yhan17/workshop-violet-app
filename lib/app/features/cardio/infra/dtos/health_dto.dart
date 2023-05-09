import 'dart:convert';

import '../../domain/entities/health_entity.dart';

class HealthDto {
  final int userId;
  final int spo2;
  final int bpm;
  final String exercise;
  HealthDto({
    required this.userId,
    required this.spo2,
    required this.bpm,
    required this.exercise,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'spo2': spo2,
      'bpm': bpm,
      'exercise': exercise,
    };
  }

  factory HealthDto.fromEntity(HealthEntity entity) {
    return HealthDto(
      userId: entity.userId,
      spo2: entity.spo2,
      bpm: entity.bpm,
      exercise: entity.exercise,
    );
  }

  factory HealthDto.fromMap(Map<String, dynamic> map) {
    return HealthDto(
      userId: map['userId']?.toInt() ?? 0,
      spo2: map['spo2']?.toInt() ?? 0,
      bpm: map['bpm']?.toInt() ?? 0,
      exercise: map['exercise'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthDto.fromJson(String source) =>
      HealthDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HealthDto(userId: $userId, spo2: $spo2, bpm: $bpm, exercise: $exercise)';
  }
}
