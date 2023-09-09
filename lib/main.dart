import 'package:flutter/material.dart';
import 'package:shop/modules/onBoarding/on_boarding.dart';
import 'package:shop/shared/styles/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}

