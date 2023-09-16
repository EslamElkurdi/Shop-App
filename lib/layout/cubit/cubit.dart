import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/favorites/favorites_changes.dart';
import 'package:shop/models/home/home.dart';
import 'package:shop/models/login/login_model.dart';
import 'package:shop/modules/bottom_nav_screens/categories_screen.dart';
import 'package:shop/modules/bottom_nav_screens/favorite_screen.dart';
import 'package:shop/modules/bottom_nav_screens/product_screen.dart';
import 'package:shop/modules/bottom_nav_screens/search_screen.dart';
import 'package:shop/modules/bottom_nav_screens/setting_screen.dart';
import 'package:shop/shared/constants/constatnts.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio.dart';

import '../../models/categories/categories_model.dart';
import '../../models/favorites/favorites_model.dart';

class ShopAppCubit extends Cubit<ShopLayoutStates> {
  ShopAppCubit() : super(ShopInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens =
      [
        const ProductScreen(),
        const CategoriesScreen(),
        const FavoriteScreen(),
        SettingScreen()
      ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;

    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value){
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data.products) {
        favorites.addAll({
          element.id : element.inFavorites
        });
      }

      print(favorites.toString());

      // print(value.data);
      emit(ShopHomeDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopHomeDataErrorState());
    });
  }

  CategoryDataModel? dataModel;



  void getCategoryData()
  {
    DioHelper.getData(
        url: GET_CATEGORIES,
        token: token
    ).then((value){
      dataModel = CategoryDataModel.fromJson(value.data);



      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      emit(ShopCategoriesErrorState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId){

    favorites[productId] = !(favorites[productId] ?? false);

     emit(ShopChangeFavoritesSuccessState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId
        },
          token: token
    ).then((value){

      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(changeFavoritesModel?.status != true) {
        favorites[productId] = !(favorites[productId] ?? false);
      }else{
        getFavoritesData();
      }

      emit(ShopFavoritesSuccessState(changeFavoritesModel: changeFavoritesModel));
    }).catchError((error){

      favorites[productId] = !(favorites[productId] ?? false);

      print(error.toString());
      emit(ShopFavoritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
        url: FAVORITES,
        token: token
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);

      print(value.data.toString());



      emit(ShopGetFavoritesSuccessState());
    }).catchError((error){
      emit(ShopGetFavoritesErrorState());
    });
  }

  LoginModel? userData;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value){
      // userData = LoginModel.fromjson(value.data);


      userData = LoginModel.fromjson(value.data);

      print(userData?.data?.name);

      emit(ShopUserDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopUserDataErrorState());
    });
  }

  void updateUserData({
  required String name,
    required phone,
    required email,
})
  {
    emit(ShopUpdateLoadingUserDataState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data:
        {
          'name' : name,
          'phone' : phone,
          'email' : email
        }
    ).then((value){
      // userData = LoginModel.fromjson(value.data);


      userData = LoginModel.fromjson(value.data);

      print(userData?.data?.name);

      emit(ShopUpdateUserDataSuccessState(userData));
    }).catchError((error){
      print(error.toString());
      emit(ShopUpdateUserDataErrorState());
    });
  }
}