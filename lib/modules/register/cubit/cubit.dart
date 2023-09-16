import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/Cubit/states.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio.dart';

import '../../../models/login/login_model.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister(
      {
        required String email,
        required String password,
        required String phone,
        required String name
      }
      )
  {
    emit(RegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data: {
          'email' : email,
          'password' : password,
          'name' : name,
          'phone' : phone

        }
    ).then((value){
      print(value.data);
      loginModel = LoginModel.fromjson(value.data);
      //print(loginModel?.data.name);

      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {

    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;

    emit(ChangeRegisterPasswordVisibility());
  }
}

