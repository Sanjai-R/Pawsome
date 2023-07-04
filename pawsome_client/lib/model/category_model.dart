class CategoryModel {
  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.img,
  });

  final int? categoryId;
  final String? categoryName;
  final String? img;

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
      categoryId: json["categoryId"],
      categoryName: json["categoryName"],
      img: json["img"],
    );
  }

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "img": img,
  };

}
