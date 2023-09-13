class CategoryDataModel {
  bool status;
  String? message;
  CategoryData? data;

  CategoryDataModel({
    required this.status,
    this.message,
    this.data,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(
      status: json['status'],
      message: json['message'],
      data: CategoryData.fromJson(json['data']),
    );
  }
}

class CategoryData {
  int currentPage;
  List<CategoryItem> items;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String? nextPageUrl;
  String path;
  int perPage;
  String? prevPageUrl;
  int to;
  int total;

  CategoryData({
    required this.currentPage,
    required this.items,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      currentPage: json['current_page'],
      items: List<CategoryItem>.from(
          json['data'].map((item) => CategoryItem.fromJson(item))),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class CategoryItem {
  int id;
  String name;
  String image;

  CategoryItem({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}