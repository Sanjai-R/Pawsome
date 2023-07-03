import 'package:dio/dio.dart';
import 'package:pawsome_client/core/constant/urls.dart';

class PetService {
  static Future<dynamic> getAllPets() async {
    try {
      final res = await Dio().get('${AppUrl.baseUrl}/Pet');
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<dynamic> getCategories() async {
    try {
      final res = await Dio().get('${AppUrl.baseUrl}/PetCategory');
      print(res);
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
