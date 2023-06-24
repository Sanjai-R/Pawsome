import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String _userName = '';
  String _email = '';
  String _password = '';
  String _phoneNumber = '';

  String get userName => _userName;
  String get email => _email;
  String get password => _password;
  String get phoneNumber => _phoneNumber;

  void setUserName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }
  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }
  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

}

