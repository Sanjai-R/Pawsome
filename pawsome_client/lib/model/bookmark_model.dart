class BookmarkModel {
  BookmarkModel({
    required this.id,
    required this.petId,
    required this.userId,
    required this.pet,
  });

  final int? id;
  final int? petId;
  final int? userId;
  final Pet? pet;

  factory BookmarkModel.fromJson(Map<String, dynamic> json){
    return BookmarkModel(
      id: json["id"],
      petId: json["petId"],
      userId: json["userId"],
      pet: json["pet"] == null ? null : Pet.fromJson(json["pet"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "petId": petId,
    "userId": userId,
    "pet": pet?.toJson(),
  };

  @override
  String toString(){
    return "$id, $petId, $userId, $pet, ";
  }
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
  final num? price;
  final DateTime? birthDate;
  final String? image;
  final int? userId;
  final int? categoryId;
  final dynamic category;
  final dynamic user;

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
      user: json["user"],
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
    "user": user,
  };

  @override
  String toString(){
    return "$petId, $name, $gender, $breed, $description, $price, $birthDate, $image, $userId, $categoryId, $category, $user, ";
  }
}
