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
        return FutureBuilder<bool>(
          future: _checkViewedStatus(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              print("snapshot data ${snapshot.data}");
              if (snapshot.data!) {
                return LoginScreen();
              } else {
                return const OnBoard();
              }
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
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
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
);

Future<bool> _checkViewedStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isViewed = prefs.getBool("onBoard");
  print(isViewed);
  return isViewed ?? false;
}
