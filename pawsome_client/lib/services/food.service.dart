import 'package:dio/dio.dart';
import 'package:pawsome_client/core/constant/urls.dart';

class FoodService {
  static Future<dynamic> getRecommendFoods(petId) async {
    final res = await Dio()
        .get('${AppUrl.baseUrl}/FoodProduct/recommended-foods/$petId');

    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.data;
    }
    return null;
  }
}
