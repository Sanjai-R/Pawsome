import 'package:dio/dio.dart';
import 'package:pawsome_client/core/constant/urls.dart';

class EventService{

  static Future<dynamic> getEventData(petId) async {
    print("petId $petId");
    try {

      final res = await Dio().get(
          '${AppUrl.baseUrl}/Event/getEventByPet/$petId'); //todo: change this to dynamic
      print(res.data);
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
  static Future<dynamic> postEvents(data) async{
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