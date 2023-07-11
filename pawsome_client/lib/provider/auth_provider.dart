import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pawsome_client/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late Map<String, dynamic> _user = <String, dynamic>{};

  dynamic get user => _user;

  String _email = '';

  String get email => _email;

  void clear() {
    _user = <String, dynamic>{};
    _email = '';
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  Future<dynamic> signUp({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    notifyListeners();
    final res = await AuthService.register(
      userName: userName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );

    if (res != null) {
      _user = res.toJson();
      setData();
      return {'status': true, 'message': 'Login Successfully'};
    } else {
      return {'status': false, 'message': 'Login Failed'};
    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    notifyListeners();
    final res = await AuthService.login(email, password);

    if (res != null) {
      _user = res.toJson();

      setData();
      return {'status': true, 'message': 'Login Successfully'};
    } else {
      return {'status': false, 'message': 'Login Failed'};
    }
  }

  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authData', json.encode(user));

    notifyListeners();
  }

  void getAuthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mapString = prefs.getString('authData');

    if (mapString != null) {
      Map<String, dynamic> authData = json.decode(mapString);
      _user = authData;
    }
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('authData');
    _user = {};
    notifyListeners();
  }

  Future<dynamic> updateProfile(data) async {
    final res = await AuthService.updateProfile(data['userId'], data);

    notifyListeners();
    if (res) {
      _user['mobile'] = data['mobile'];
      _user['location'] = data['location'];
      _user['profile'] = data['profile'];
      return {'status': true, 'message': 'Profile updated Successfully'};
    } else {
      return {'status': false, 'message': 'Profile updated Failed'};
    }
  }

  Future<dynamic> SendOtp(String email) async {
    final res = await AuthService.sendOtp(email);
    notifyListeners();
    if (res != null) {
      return {'status': true, 'message': 'Otp Sent Successfully'};
    } else {
      return {'status': false, 'message': 'Otp Sent Failed'};
    }
  }

  Future<dynamic> verifyOtp(String email, String otp) async {
    final res = await AuthService.verifyOtp(email, otp);
    notifyListeners();
    if (res != null) {
      return {'status': true, 'message': 'Otp verified Successfully'};
    } else {
      return {'status': false, 'message': 'Otp verified Failed,check your otp'};
    }
  }

  Future<dynamic> resetPassword(String email, String password) async {
    final res = await AuthService.resetPassword(email, password);
    notifyListeners();
    if (res != null) {
      return {'status': true, 'message': 'Password reset Successfully'};
    } else {
      return {'status': false, 'message': 'Password reset Failed'};
    }
  }
}
