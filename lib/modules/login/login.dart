import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/Cubit/cubit.dart';
import 'package:shop/modules/login/Cubit/states.dart';
import 'package:shop/modules/register/register.dart';
import 'package:shop/shared/component/components.dart';
import 'package:shop/shared/constants/constatnts.dart';
import 'package:shop/shared/network/remote/cach_helper.dart';

import '../../layout/shop_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state){
            if(state is LoginSuccessState)
            {
              if(state.model?.status == true){
                // print(state.model?.message);
                // //showToastMessage(state.model.message);
                // print(state.model?.data?.token);
                showToast(state.model?.message);
                CacheHelper.saveData(
                    key: 'token',
                    value: state.model?.data?.token
                ).then((value){
                  token = state.model!.data!.token!;

                  navigateAndFinish(context,  ShopLayout());
                });


              }else{

                showToast(state.model?.message);
              }

            }
          },
        builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LOGIN",
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                              "login now to browse our hot offers",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Colors.grey
                              )
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          // email
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value)
                              {
                                if(value!.isEmpty){
                                  return 'Enter Your Email';
                                }
                              },
                              label: "Email Address",
                              prefIcon: Icons.email_outlined
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          // Password
                          defaultFormField(
                            onSubmit: (value)
                            {
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                              secureText: LoginCubit.get(context).isPassword,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String? value)
                              {
                                if(value!.isEmpty){
                                  return 'Enter Your Password';
                                }
                              },
                              label: "Password",
                              prefIcon: Icons.lock_outline,
                              sufx: Icons.visibility_off,
                              onTapSuff: ()
                              {
                                LoginCubit.get(context).changePasswordVisibility();

                              }

                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context)=>defaultButton(
                                  function: (){
                                     if(formKey.currentState!.validate()){
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text
                                      );
                                    }

                                  },
                                  buttonName: 'LOGIN'
                              ),
                              fallback: (context)=> const Center(child: CircularProgressIndicator())
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don\'t have an account?"),

                              TextButton(
                                  onPressed: (){
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: Text("Register")
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        },
      )
    );
  }
}
