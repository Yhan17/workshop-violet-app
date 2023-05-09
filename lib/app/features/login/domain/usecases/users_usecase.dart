import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

abstract class UsersUsecase {
  final UserRepository repository;
  UsersUsecase({
    required this.repository,
  });

  Future<Either<Failures, List<UserEntity>>> call() {
    return repository.fetchUsers();
  }
}
