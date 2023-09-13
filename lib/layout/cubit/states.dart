import 'package:shop/models/favorites/favorites_changes.dart';

abstract class ShopLayoutStates {}

class ShopInitialState extends ShopLayoutStates {}

class ShopChangeBottomNavBarState extends ShopLayoutStates {}

class ShopLoadingHomeDataState extends ShopLayoutStates {}

class ShopHomeDataSuccessState extends ShopLayoutStates {}

class ShopHomeDataErrorState extends ShopLayoutStates {}

class ShopCategoriesSuccessState extends ShopLayoutStates {}

class ShopCategoriesErrorState extends ShopLayoutStates {}

class ShopFavoritesSuccessState extends ShopLayoutStates {
  final ChangeFavoritesModel? changeFavoritesModel;
  ShopFavoritesSuccessState({required this.changeFavoritesModel});
}

class ShopChangeFavoritesSuccessState extends ShopLayoutStates
{

}

class ShopFavoritesErrorState extends ShopLayoutStates {}

class ShopGetFavoritesSuccessState extends ShopLayoutStates {}

class ShopGetFavoritesErrorState extends ShopLayoutStates {}

class ShopLoadingGetFavoritesState extends ShopLayoutStates {}


