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
  final dynamic pet;

  factory Event.fromJson(Map<String, dynamic> json){
    return Event(
      eventId: json["eventId"],
      petId: json["petId"],
      eventDateTime: DateTime.tryParse(json["eventDateTime"] ?? ""),
      eventTitle: json["eventTitle"],
      eventDesc: json["eventDesc"],
      hasReminder: json["hasReminder"],
      pet: json["pet"],
    );
  }

  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "petId": petId,
    "eventDateTime": eventDateTime?.toIso8601String(),
    "eventTitle": eventTitle,
    "eventDesc": eventDesc,
    "hasReminder": hasReminder,
    "pet": pet,
  };

}
