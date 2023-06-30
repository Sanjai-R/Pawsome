class Event {
  Event({
    required this.eventId,
    required this.petId,
    required this.eventDateTime,
    required this.eventTitle,
    required this.eventDesc,
    required this.hasReminder,
    required this.pet,
  });

  final int? eventId;
  final int? petId;
  final DateTime? eventDateTime;
  final String? eventTitle;
  final String? eventDesc;
  final bool? hasReminder;
  final Pet? pet;

  factory Event.fromJson(Map<String, dynamic> json){
    return Event(
      eventId: json["eventId"],
      petId: json["petId"],
      eventDateTime: DateTime.tryParse(json["eventDateTime"] ?? ""),
      eventTitle: json["eventTitle"],
      eventDesc: json["eventDesc"],
      hasReminder: json["hasReminder"],
      pet: json["pet"] == null ? null : Pet.fromJson(json["pet"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "petId": petId,
    "eventDateTime": eventDateTime?.toIso8601String(),
    "eventTitle": eventTitle,
    "eventDesc": eventDesc,
    "hasReminder": hasReminder,
    "pet": pet?.toJson(),
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
    required this.ownerId,
    required this.categoryId,
    required this.category,
    required this.user,
  });

  final int? petId;
  final String? name;
  final String? gender;
  final String? breed;
  final String? description;
  final int? price;
  final DateTime? birthDate;
  final String? image;
  final int? ownerId;
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
      ownerId: json["ownerId"],
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
    "ownerId": ownerId,
    "categoryId": categoryId,
    "category": category,
    "user": user,
  };

}