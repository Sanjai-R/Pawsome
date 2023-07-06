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
  static Future<dynamic> getPetById(id) async {
    try {
      final res = await Dio().get('${AppUrl.baseUrl}/Pet/$id');

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

      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
  static Future<bool> postPet(data) async{
    try {
      final res = await Dio().post('${AppUrl.baseUrl}/Pet', data: data);
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
  static Future<dynamic> postAdopt(data) async {
    try {
      final res = await Dio().post('${AppUrl.baseUrl}/Adoption', data: data);
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<dynamic> getAdoptedData() async {
    try {
      final res = await Dio().get('${AppUrl.baseUrl}/Adoption');
      print(res);
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<dynamic> updateAdoptStatus(id, data) async {
    try {
      final res = await Dio().put('${AppUrl.baseUrl}/Adoption/$id', data: data);
      print(res);
      if (res != null && (res.statusCode == 204 || res.statusCode == 201)) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<dynamic> postBookMark(data) async{
    try {
      final res = await Dio().post('${AppUrl.baseUrl}/BookMark', data: data);
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
  static Future<dynamic> getBookMarks(userID)async{
    try {
      final res = await Dio().get('${AppUrl.baseUrl}/BookMark/$userID');

      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
