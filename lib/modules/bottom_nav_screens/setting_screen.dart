import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/shared/component/components.dart';
import 'package:shop/shared/constants/constatnts.dart';

class SettingScreen extends StatelessWidget {
  //const SettingScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopLayoutStates>(
      listener: (context, state){},
      builder: (context, state){

        var model = ShopAppCubit.get(context).userData;

        emailController.text = model!.data!.email!;
        nameController.text = model.data!.name!;
        phoneController.text = model.data!.phone!;



        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children:
              [
                if(state is ShopUpdateLoadingUserDataState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 15,
                ),
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (value)
                    {
                      if(value!.isEmpty){
                        return 'Name must not be empty';
                      }

                      return null;
                    },
                    label: 'Name',
                    prefIcon: Icons.person
                ),

                const SizedBox(
                  height: 15,
                ),
                defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value)
                    {
                      if(value!.isEmpty){
                        return 'Email Address must not be empty';
                      }

                      return null;
                    },
                    label: 'Email Address',
                    prefIcon: Icons.email_outlined
                ),
                const SizedBox(
                  height: 15,
                ),
                defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value)
                    {
                      if(value!.isEmpty){
                        return 'phone must not be empty';
                      }

                      return null;
                    },
                    label: 'Phone',
                    prefIcon: Icons.phone
                ),
                const SizedBox(
                  height: 30,
                ),
                defaultButton(
                    function: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        ShopAppCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }

                    },
                    buttonName: 'UPDATE'
                ),
                const SizedBox(
                  height: 30,
                ),
                defaultButton(
                    function: ()
                    {
                      signOut(context);
                    },
                    buttonName: 'LOGOUT'
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}