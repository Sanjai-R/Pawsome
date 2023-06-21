import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/screens/homeScreen.dart';
import 'package:pawsome_client/screens/onboard.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return OnBoard();
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
