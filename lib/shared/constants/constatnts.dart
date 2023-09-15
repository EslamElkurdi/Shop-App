
import 'package:flutter/material.dart';
import '../../modules/login/login.dart';
import '../component/components.dart';
import '../network/remote/cach_helper.dart';


String token='';

void signOut(context) {
  CacheHelper.clearData(key: 'token').then((value) {
    navigateAndFinish(context, LoginScreen());
  });
}


