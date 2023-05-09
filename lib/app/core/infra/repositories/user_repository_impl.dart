import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_entity.dart';
import '../../failures/failures.dart';
import '../../http/backend_http_client.dart';
import '../../repositories/user_repository.dart';
import '../dtos/user_dto.dart';

class UserRepositoryImpl extends UserRepository {
  final BackendHttpClient client;
  UserRepositoryImpl({
    required this.client,
  });
  @override
  Future<Either<Failures, UserEntity>> fetchUser(String name) async {
    try {
      final result = await client.post('/user/login', data: {
        'name': name,
      });

      final user = UserDto.fromMap(result.data['data']);

      final prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('user')) {
        prefs.remove('user');
      }

      prefs.setString('user', json.encode(user.toMap()));

      return right(user.toEntity());
    } catch (_) {
      return left(Failures.serverFailures);
    }
  }

  @override
  Future<Either<Failures, List<UserEntity>>> fetchUsers() async {
    try {
      final result = await client.get('/user/index');

      final users = List.from(result.data['data'])
          .map(
            (user) => UserDto.fromMap(user).toEntity(),
          )
          .toList();

      return right(users);
    } catch (_) {
      return left(Failures.serverFailures);
    }
  }
}
