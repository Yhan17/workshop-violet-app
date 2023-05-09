import 'package:equatable/equatable.dart';

class HealthEntity extends Equatable {
  final int userId;
  final int spo2;
  final int bpm;
  final String exercise;
  const HealthEntity({
    required this.userId,
    required this.spo2,
    required this.bpm,
    required this.exercise,
  });

  @override
  List<Object?> get props => [
        userId,
        spo2,
        bpm,
        exercise,
      ];
}
