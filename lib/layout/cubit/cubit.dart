import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/home/home.dart';
import 'package:shop/modules/bottom_nav_screens/categories_screen.dart';
import 'package:shop/modules/bottom_nav_screens/favorite_screen.dart';
import 'package:shop/modules/bottom_nav_screens/product_screen.dart';
import 'package:shop/modules/bottom_nav_screens/search_screen.dart';
import 'package:shop/modules/bottom_nav_screens/setting_screen.dart';
import 'package:shop/shared/constants/constatnts.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio.dart';

class ShopAppCubit extends Cubit<ShopLayoutStates> {
  ShopAppCubit() : super(ShopInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens =
      [
        const ProductScreen(),
        const CategoriesScreen(),
        const FavoriteScreen(),
        const SettingScreen()
      ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;

    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;

  void getHomeData()
  {
    emit(ShopLoadingHomeData());

    DioHelper.getData(url: HOME, token: token).then((value){
      homeModel = HomeModel.fromJson(value.data);
      print(value.data);
      emit(ShopHomeDataSuccess());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeDataError());
    });
  }
}