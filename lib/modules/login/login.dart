import 'package:flutter/material.dart';
import 'package:shop/shared/component/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
              onTapSuff: (){}
            ),
            const SizedBox(
              height: 25.0,
            ),
            defaultButton(
                function: (){

                },
                buttonName: 'LOGIN'
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text("Don\'t have an account?"),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: (){},
                    child: Text("Register")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
