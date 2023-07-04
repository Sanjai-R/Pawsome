class PetModel {
  PetModel({
    required this.petId,
    required this.name,
    required this.gender,
    required this.breed,
    required this.description,
    required this.price,
    required this.birthDate,
    required this.image,
    required this.userId,
    required this.categoryId,
    required this.category,
    required this.user,
  });

  final int? petId;
  final String? name;
  final String? gender;
  final String? breed;
  final String? description;
  final dynamic? price;
  final DateTime? birthDate;
  final String? image;
  final int? userId;
  final int? categoryId;
  final Category? category;
  final User? user;

  factory PetModel.fromJson(Map<String, dynamic> json){
    return PetModel(
      petId: json["petId"],
      name: json["name"],
      gender: json["gender"],
      breed: json["breed"],
      description: json["description"],
      price: json["price"],
      birthDate: DateTime.tryParse(json["birthDate"] ?? ""),
      image: json["image"],
      userId: json["userId"],
      categoryId: json["categoryId"],
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "petId": petId,
    "name": name,
    "gender": gender,
    "breed": breed,
    "description": description,
    "price": price,
    "birthDate": birthDate?.toIso8601String(),
    "image": image,
    "userId": userId,
    "categoryId": categoryId,
    "category": category?.toJson(),
    "user": user?.toJson(),
  };

}

class Category {
  Category({
    required this.categoryId,
    required this.categoryName,
    required this.img,
  });

  final int? categoryId;
  final String? categoryName;
  final String? img;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
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

class User {
  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.mobile,
    required this.location,
    required this.notificationId,
  });

  final int? userId;
  final String? username;
  final String? email;
  final String? password;
  final String? mobile;
  final String? location;
  final String? notificationId;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      userId: json["userId"],
      username: json["username"],
      email: json["email"],
      password: json["password"],
      mobile: json["mobile"],
      location: json["location"],
      notificationId: json["notificationId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "email": email,
    "password": password,
    "mobile": mobile,
    "location": location,
    "notificationId": notificationId,
  };

}
