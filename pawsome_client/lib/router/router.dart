import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/screens/error_screen.dart';
import 'package:pawsome_client/screens/home_screen.dart';
import 'package:pawsome_client/screens/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return FutureBuilder<bool>(
          future: checkViewedStatus(), // Check the SharedPreferences value
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // If the future is still loading, show a loading screen
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // If the future completed successfully, check the value
              final bool isViewed = snapshot.data!;
              if (isViewed) {
                // If isViewed is true, navigate to the HomeScreen
                return  const HomeScreen();
              } else {
                // If isViewed is false, navigate to the OnBoard screen
                return const OnBoard();
              }
            } else {
              // If the future encountered an error, show an error screen
              return Error404Screen();
            }
          },
        );
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    )
  ],
);

Future<bool> checkViewedStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? isViewed = prefs.getInt('onBoard');
  print(isViewed);
  return isViewed == 1;
}
