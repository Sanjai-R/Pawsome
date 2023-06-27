// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:dio/dio.dart';
import 'package:pawsome_client/core/constant/urls.dart';
import 'package:pawsome_client/model/user_model.dart';

class AuthService {
  static Future<User?> login(String email, String password) async {
    try {
      final res = await Dio().post('${AppUrl.baseUrl}/User/login',
          data: {"email": email, "password": password});

      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return User.fromJson(res.data);
      }
    } catch (e) {
      print(e);
    }
    return null; // Return null when login fails or response is null
  }

  static Future<User?> register({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final res = await Dio().post('${AppUrl.baseUrl}/User', data: {
        "email": email,
        "password": password,
        "username": userName,
        "mobile": phoneNumber,
        "location": "Chennai,TN", //todo: add location
        "NotificationId": "" //todo: add notification id
      });
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return User.fromJson(res.data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<dynamic> sendOtp(String email) async {
    try {
      final res =
          await Dio().get('${AppUrl.baseUrl}/User/SendOtp/email=$email');
      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<dynamic> verifyOtp(String email, String otp) async {
    try {
      final res = await Dio()
          .get('${AppUrl.baseUrl}/User/VerifyOtp/otp=$otp/email=$email');

      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<dynamic> resetPassword(String email, String password) async {
    try {
      final res = await Dio().put('${AppUrl.baseUrl}/User/ResetPassword',
          data: {"email": email, "password": password});

      if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
        return res.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
