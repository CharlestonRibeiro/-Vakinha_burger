import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/exceptions/unauthorized_exceptions.dart';
import 'package:vakinha_burger_provider_com_bloc/app/core/keys/keys.dart';
import 'package:vakinha_burger_provider_com_bloc/app/pages/auth/login/login_status.dart';
import 'package:vakinha_burger_provider_com_bloc/app/repositories/auth/auth_repository.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginController(this._authRepository) : super(const LoginState.initial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authModel = await _authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();
      sp.setString( Keys.accessToken, authModel.accessToken);
      sp.setString( Keys.refreshToken, authModel.refreshToken);
      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedExceptions catch (e, s) {
      log('Login e senha inválidos', error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.loginError,
          errorMessage: 'Login ou senha inválidos'));
    } catch (e, s) {
      log('Error ao realizar login', error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.error, errorMessage: 'Error ao realizar login'));
    }
  }
}
