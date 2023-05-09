import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:violet/app/features/maps/domain/usecases/users_usecase.dart';

import '../../../../core/common_state/common_state.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/domain/entities/user_entity.dart';

class UsersController extends ChangeNotifier {
  final UsersUsecase _userUsecase;

  UsersController(this._userUsecase);

  Future<Either<Failures, List<UserEntity>>> fetchUsers(
    BuildContext context,
  ) async {
    final result = await _userUsecase.call();

    return result;
  }
}
