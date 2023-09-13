import 'package:shop/models/login/login_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {

  final LoginModel? model;

  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibility extends LoginState {}