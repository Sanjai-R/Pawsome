import 'package:flutter/cupertino.dart';
import 'package:pawsome_client/services/auth.service.dart';

class AuthProvider extends ChangeNotifier {
  void signUp({
    required String userName,
    required String email,
    required String password,
    required String phoneNumber,
  }) {
    print('sign up');
  }
  Future<void> login ({
    required String email,
    required String password,
  }) async {
    AuthService.login(email, password);
  }
}
