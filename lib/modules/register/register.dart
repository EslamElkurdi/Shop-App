import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/register/cubit/cubit.dart';
import 'package:shop/modules/register/cubit/states.dart';

import '../../layout/shop_layout.dart';
import '../../shared/component/components.dart';
import '../../shared/constants/constatnts.dart';
import '../../shared/network/remote/cach_helper.dart';

class RegisterScreen extends StatelessWidget {
  // const RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  RegisterScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state)
        {
          if(state is RegisterSuccessState)
          {
            if(state.model?.status == true){
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
                          "Register",
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                            "Register now to browse our hot offers",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            )
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        // NAME
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? value)
                            {
                              if(value!.isEmpty){
                                return 'Enter Your Name';
                              }
                            },
                            label: "User Name",
                            prefIcon: Icons.person
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        // Email
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value)
                            {
                              if(value!.isEmpty){
                                return 'Enter Your Email';
                              }
                            },
                            label: "Email",
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
                                // LoginCubit.get(context).userLogin(
                                //     email: emailController.text,
                                //     password: passwordController.text
                                // );
                              }
                            },
                            // secureText: LoginCubit.get(context).isPassword,
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
                              // LoginCubit.get(context).changePasswordVisibility();

                            }

                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value)
                            {
                              if(value!.isEmpty){
                                return 'Enter Your phone number';
                              }
                            },
                            label: "Phone",
                            prefIcon: Icons.phone
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context)=>defaultButton(
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text
                                    );
                                  }

                                },
                                buttonName: 'Register'
                            ),
                            fallback: (context)=> const Center(child: CircularProgressIndicator())
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
