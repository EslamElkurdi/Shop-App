import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/Cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio.dart';

import '../../../models/login/login_model.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin(
  {
  required String email,
    required String password
}
)
  {
    emit(LoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data: {
          'email' : email,
          'password' : password
        }
    ).then((value){
      print(value.data);
      loginModel = LoginModel.fromjson(value.data);
      //print(loginModel?.data.name);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {

    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;

    emit(ChangePasswordVisibility());
  }
}

