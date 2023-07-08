class AdoptModel {
  AdoptModel({
    required this.id,
    required this.petId,
    required this.buyerId,
    required this.status,
    required this.date,
    required this.pet,
    required this.buyer,
  });

  final int? id;
  final int? petId;
  final int? buyerId;
  final String? status;
  final DateTime? date;
  final Pet? pet;
  final Buyer? buyer;

  factory AdoptModel.fromJson(Map<String, dynamic> json){
    return AdoptModel(
      id: json["id"],
      petId: json["petId"],
      buyerId: json["buyerId"],
      status: json["status"],
      date: DateTime.tryParse(json["date"] ?? ""),
      pet: json["pet"] == null ? null : Pet.fromJson(json["pet"]),
      buyer: json["buyer"] == null ? null : Buyer.fromJson(json["buyer"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "petId": petId,
    "buyerId": buyerId,
    "status": status,
    "date": date?.toIso8601String(),
    "pet": pet?.toJson(),
    "buyer": buyer?.toJson(),
  };

}

class Buyer {
  Buyer({
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

  factory Buyer.fromJson(Map<String, dynamic> json){
    return Buyer(
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

class Pet {
  Pet({
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
  final dynamic price;
  final DateTime? birthDate;
  final String? image;
  final int? userId;
  final int? categoryId;
  final dynamic category;
  final Buyer? user;

  factory Pet.fromJson(Map<String, dynamic> json){
    return Pet(
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
      category: json["category"],
      user: json["user"] == null ? null : Buyer.fromJson(json["user"]),
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
    "category": category,
    "user": user?.toJson(),
  };

}
