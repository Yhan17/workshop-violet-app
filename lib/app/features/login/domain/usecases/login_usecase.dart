import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

abstract class LoginUsecase {
  final UserRepository repository;
  LoginUsecase({
    required this.repository,
  });

  Future<Either<Failures, UserEntity>> call(String name) {
    return repository.fetchUser(name);
  }
}
