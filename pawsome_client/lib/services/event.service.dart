import 'package:dio/dio.dart';
import 'package:pawsome_client/core/constant/urls.dart';

class EventService{
  static Future<dynamic> getEvents() async{
    print("getEvents");
    try {
      final res =
      await Dio().get('${AppUrl.baseUrl}/Event');
      print(res);
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {

        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<dynamic> postEvents(data) async{
    print(data);
    try {
      final res =
      await Dio().post('${AppUrl.baseUrl}/Event',data: data);
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