class MealTrackerModel {
  MealTrackerModel({
    this.mealTrackerId,
    this.dailyPlan,
     this.foodConsumed,
    this.nutrientTrackerId,
    this.petId,
    this.nutrientTracker,
  });

  final int? mealTrackerId;
  late final int? dailyPlan;
  late final int? foodConsumed;
  final int? nutrientTrackerId;
  final int? petId;
  late final NutrientTracker? nutrientTracker;

  factory MealTrackerModel.fromJson(Map<String, dynamic> json){
    return MealTrackerModel(
      mealTrackerId: json["mealTrackerId"],
      dailyPlan: json["dailyPlan"],
      foodConsumed: json["foodConsumed"],
      nutrientTrackerId: json["nutrientTrackerId"],
      petId: json["petId"],
      nutrientTracker: json["nutrientTracker"] == null ? null : NutrientTracker.fromJson(json["nutrientTracker"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "mealTrackerId": mealTrackerId,
    "dailyPlan": dailyPlan,
    "foodConsumed": foodConsumed,
    "nutrientTrackerId": nutrientTrackerId,
    "petId": petId,
    "nutrientTracker": nutrientTracker?.toJson(),
  };

}

class NutrientTracker {
  NutrientTracker({
    required this.nutrientTrackerId,
    required this.proteinPlan,
    required this.proteinConsumed,
    required this.fatPlan,
    required this.fatConsumed,
    required this.carbsPlan,
    required this.carbsConsumed,
  });

  final int? nutrientTrackerId;
  final int? proteinPlan;
  final int? proteinConsumed;
  final int? fatPlan;
  final int? fatConsumed;
  final int? carbsPlan;
  final int? carbsConsumed;

  factory NutrientTracker.fromJson(Map<String, dynamic> json){
    return NutrientTracker(
      nutrientTrackerId: json["nutrientTrackerId"],
      proteinPlan: json["proteinPlan"],
      proteinConsumed: json["proteinConsumed"],
      fatPlan: json["fatPlan"],
      fatConsumed: json["fatConsumed"],
      carbsPlan: json["carbsPlan"],
      carbsConsumed: json["carbsConsumed"],
    );
  }

  Map<String, dynamic> toJson() => {
    "nutrientTrackerId": nutrientTrackerId,
    "proteinPlan": proteinPlan,
    "proteinConsumed": proteinConsumed,
    "fatPlan": fatPlan,
    "fatConsumed": fatConsumed,
    "carbsPlan": carbsPlan,
    "carbsConsumed": carbsConsumed,
  };

}
