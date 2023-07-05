import 'package:flutter/material.dart';
import 'package:pawsome_client/model/meal_tracker_model.dart';
import 'package:pawsome_client/services/tracker.service.dart';

class TrackerProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  MealTrackerModel? _mealTracker = MealTrackerModel();
  Map<String, dynamic> mealData = {
    "mealTrackerId": 0,
    "dailyPlan": 0,
    "foodConsumed": 0,
    "nutrientTrackerId": 0,
    "petId": 0,
    "nutrientTracker": {
      "nutrientTrackerId": 0,
      "proteinPlan": 0,
      "proteinConsumed": 0,
      "fatPlan": 0,
      "fatConsumed": 0,
      "carbsPlan": 0,
      "carbsConsumed": 0
    }
  };

  bool get hasError => _hasError;

  String get errorMessage => _errorMessage;

  MealTrackerModel? get mealTracker => _mealTracker;

  bool get isLoading => _isLoading;

  Future<dynamic> createMealTrackerPlan(data) async {
    final res = await TrackerService.postMeal(data);
    if (res != null) {
      return {'status': true, 'message': 'Event Posted Successfully'};
    } else {
      return {'status': false, 'message': 'Event Posting Failed'};
    }
  }

  Future<dynamic> getMealTrack(petId) async {
    _isLoading = true;
    notifyListeners();
    final res = await TrackerService.getMealTrackingData(petId);
    print(res);
    if (res.isNotEmpty) {
      _mealTracker = MealTrackerModel.fromJson(res[0]);
      _hasError = false;
      _errorMessage = '';
    } else {
      _mealTracker = null;
      _hasError = true;
      _errorMessage = 'Failed to get events';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<dynamic> updateMealPlan(data) async {
    print(data);
    final res = await TrackerService.updateNutrients(
        data['nutrientTrackerId'].toString(), data);

    if (res) {
      return {"status": true, "message": "Meal Plan Updated Successfully"};
    } else {
      return {"status": false, "message": "Failed to update meal plan"};
    }
  }

  Future<dynamic> updateMeal(MealTrackerModel meal, data) async {
    Map<String, dynamic> map = meal.toJson()['nutrientTracker'];
    final res = await TrackerService.getNutrients(data.split(","));
    Map<String, dynamic> nut = calculateNutrients(res);
    map['proteinConsumed'] =
        (meal.nutrientTracker!.proteinConsumed! + nut['Protein']);
    map['fatConsumed'] = meal.nutrientTracker!.fatConsumed! + nut['Fat'];
    map['carbsConsumed'] = meal.nutrientTracker!.carbsConsumed! + nut['Carbs'];
    final updatedRes = await TrackerService.updateNutrients(
        meal.nutrientTracker!.nutrientTrackerId, map);
    if (updatedRes) {
      return {"status": true, "message": "Nutrients Updated Successfully"};
    } else {
      return {"status": false, "message": "Failed to update nutrients"};
    }
  }

  Map<String, dynamic> calculateNutrients(Map<String, dynamic> json) {
    final totalNutrients = json['totalNutrients'] as Map<String, dynamic>;
    final totalDaily = json['totalDaily'] as Map<String, dynamic>;
    Map<String, dynamic> mp = {};
    print('Total Nutrients:');

    totalDaily.forEach((key, value) {
      final label = value['label'] as String;
      final quantity = value['quantity'] as double;
      if (label == "Fat" || label == "Protein" || label == "Carbs") {
        mp[label] = quantity.toInt();
      }
    });
    return mp;
  }
}
