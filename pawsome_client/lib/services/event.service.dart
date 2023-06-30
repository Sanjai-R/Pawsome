import 'package:dio/dio.dart';
import 'package:pawsome_client/core/constant/urls.dart';

class EventService{
  static Future<dynamic> getEvents() async{
    try {
      final res =
      await Dio().get('${AppUrl.baseUrl}/Event');
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        print(res);
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}