import 'package:flutter/foundation.dart';

import '../../domain/entities/user_entity.dart';

@immutable
class UserDto {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String? latitude;
  final String? longitude;
  const UserDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id']?.toInt() ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      name: map['name'] ?? '',
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  UserEntity toEntity() => UserEntity(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        name: name,
        latitude: latitude,
        longitude: longitude,
      );
}
