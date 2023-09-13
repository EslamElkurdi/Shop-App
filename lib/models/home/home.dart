class HomeModel
{
  late bool status;
  late DataModel data;
  HomeModel.fromJson(Map<String, dynamic> json){

    status = json['status'];
    data = DataModel.fromJson(Map<String, dynamic>.from(json['data']));
  }

}

class DataModel
{
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  DataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element){
      //Map<String, dynamic>.from(json['lowest'])
      banners.add(BannersModel.fromJson(Map<String, dynamic>.from(element)));
    });

    json['products'].forEach((element){
      //products.add(element);
      products.add(ProductsModel.fromJson(Map<String, dynamic>.from(element)));
    });
  }


}

class BannersModel
{
  late int id;
  late String image;

  BannersModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }

}

class ProductsModel
{


  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;
  String? name;
  late bool inFavorites;
  late bool inCart;

  ProductsModel.fromJson(Map<String, dynamic> json)
  {


    id = json['id'];
    name = json['name'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
