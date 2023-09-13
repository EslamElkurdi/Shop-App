class ChangeFavoritesModel {
  late bool status;
  late String message;
  late Data data;

  ChangeFavoritesModel({required this.status, required this.message, required this.data});

  factory ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    return ChangeFavoritesModel(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int id;
  Product product;

  Data({required this.id, required this.product});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  int id;
  int price;
  int oldPrice;
  int discount;
  String image;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
    );
  }
}