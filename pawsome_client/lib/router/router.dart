import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/screens/auth/login.dart';
import 'package:pawsome_client/screens/auth/sign_up_screen.dart';
import 'package:pawsome_client/screens/home_screen.dart';
import 'package:pawsome_client/screens/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return OnBoard();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return SignUpScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
  ],
  redirect: (context, state) async {
    final isViewed = await _checkViewedStatus();
    final isLoggedIn = await _checkAuth();

    if (!isViewed && !isLoggedIn) {
      return '/';
    } else if (isViewed && !isLoggedIn) {
      return '/login';
    } else {
      return '/home';
    }
  },
);

Future<bool> _checkViewedStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isViewed = prefs.getBool("onBoard");

  return isViewed ?? false;
}

Future<bool> _checkAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final authData = prefs.getString('authData');

  return authData != null;
}
