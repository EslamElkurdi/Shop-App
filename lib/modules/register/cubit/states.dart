import 'package:shop/models/login/login_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {

  final LoginModel? model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class ChangeRegisterPasswordVisibility extends RegisterState {}