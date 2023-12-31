import 'package:shop/models/favorites/favorites_changes.dart';
import 'package:shop/models/login/login_model.dart';

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

class ShopChangeFavoritesSuccessState extends ShopLayoutStates {

}

class ShopFavoritesErrorState extends ShopLayoutStates {}

class ShopGetFavoritesSuccessState extends ShopLayoutStates {}

class ShopGetFavoritesErrorState extends ShopLayoutStates {}

class ShopLoadingGetFavoritesState extends ShopLayoutStates {}


class ShopUserDataSuccessState extends ShopLayoutStates {}

class ShopUserDataErrorState extends ShopLayoutStates {}

class ShopLoadingUserDataState extends ShopLayoutStates {}

class ShopUpdateUserDataSuccessState extends ShopLayoutStates {

  final LoginModel? model;

  ShopUpdateUserDataSuccessState(this.model);
}

class ShopUpdateUserDataErrorState extends ShopLayoutStates {}

class ShopUpdateLoadingUserDataState extends ShopLayoutStates {}


