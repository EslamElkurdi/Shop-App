
import 'package:flutter/material.dart';
import '../../modules/login/login.dart';
import '../component/components.dart';
import '../network/remote/cach_helper.dart';

void signOut(context) => TextButton(onPressed: (){
  CacheHelper.clearData(key: 'token').then((value){
    navigateAndFinish(context, LoginScreen());
  });
}, child: const Text('SIGN OUT'));


String token = '';