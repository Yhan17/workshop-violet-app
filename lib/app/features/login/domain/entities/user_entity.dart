import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String? latitude;
  final String? longitude;
  const UserEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        name,
        latitude,
        longitude,
      ];
}
