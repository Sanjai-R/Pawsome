import 'package:dio/dio.dart';
import 'package:pawsome_client/core/constant/urls.dart';

class AuthService {
  static Future<bool> login(String username, String password) async {
    try {
      print('${AppUrl.baseUrl}/login');
      final res = await Dio().post('${AppUrl.baseUrl}/User/login',
          data: {"email": "test@gmail.com", "password": "1234"});
      print(res);
    } catch (e) {
      print(e);
    }

    return username == 'admin' && password == 'admin';
  }

  static Future<bool> register(String username, String password) async {
    final res = await Dio().post('${AppUrl.baseUrl}');

    return username == 'admin' && password == 'admin';
  }
}
