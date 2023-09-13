import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/modules/onBoarding/on_boarding.dart';
import 'package:shop/shared/bloc_observer.dart';
import 'package:shop/shared/constants/constatnts.dart';
import 'package:shop/shared/network/remote/cach_helper.dart';
import 'package:shop/shared/network/remote/dio.dart';
import 'package:shop/shared/styles/themes/themes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

   DioHelper.init();
   await CacheHelper.init();

  bool? onBoardingState = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  Widget startWidget;

  if(onBoardingState != null)
  {
    if(token != null)
    {
      startWidget = ShopLayout();
    }else{
      startWidget = LoginScreen();
    }
  }else{
    startWidget = OnBoardingScreen();
  }

  print(onBoardingState);

  runApp( MyApp(onBoardingState: onBoardingState,startWidget: startWidget,));
}

class MyApp extends StatelessWidget {
  bool? onBoardingState;
  Widget? startWidget;

   MyApp({super.key, required this.onBoardingState, this.startWidget});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppCubit()..getHomeData()..getCategoryData(),
      child: BlocConsumer<ShopAppCubit, ShopLayoutStates>(
        listener: (context, state){},
        builder: (context, state) => MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget
        ),
      ),
    );
  }
}

