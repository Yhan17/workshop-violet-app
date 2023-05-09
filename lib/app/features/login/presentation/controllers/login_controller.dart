import 'package:flutter/material.dart';

import '../../../../core/common_state/common_state.dart';
import '../../../../core/failures/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';

typedef LoginState = CommonState<Failures, UserEntity>;

class LoginController extends ChangeNotifier {
  late LoginState state = const LoginState.initial();
  final LoginUsecase _loginUsecase;

  LoginController(this._loginUsecase);

  Future<void> login(String name, BuildContext context) async {
    state = const LoginState.loadInProgress();
    notifyListeners();

    final result = await _loginUsecase.call(name);

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('erro ao logar'),
          ),
        );
        state = LoginState.loadFailure(failure);
      },
      (success) {
        state = LoginState.loadSuccess(success);
      },
    );
    notifyListeners();
  }
}
