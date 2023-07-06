import 'package:dio/dio.dart';
import 'package:pawsome_client/core/constant/urls.dart';

class TrackerService {
  static Future<dynamic> getMealTrackingData(petId) async {
    print("petId $petId");
    try {

      final res = await Dio().get(
          '${AppUrl.baseUrl}/MealTracker/getMealTrackerByPet/$petId'); //todo: change this to dynamic

      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<bool> updateNutrients(id, data) async {
    try {
      final res = await Dio().put('${AppUrl.baseUrl}/NutrientTracker/$id',
          data: data); //todo: change this to dynamic

      if ((res.statusCode == 200 || res.statusCode == 204)) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<dynamic> postMeal(data) async {
    try {
      final res = await Dio().post('${AppUrl.baseUrl}/MealTracker', data: data);
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<dynamic> getNutrients(data) async {
    print("getNutrients");

    try {
      final res = await Dio().post(
          'https://api.edamam.com/api/nutrition-details?app_id=7c3ae02c&app_key=3ab2c2a38a7b43fb28ddb1d6ae4a62a7',
          data: {"ingr": data}); //todo: change this to dynamic

      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
