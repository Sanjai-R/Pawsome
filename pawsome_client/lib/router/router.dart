import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/model/pet_model.dart';
import 'package:pawsome_client/screens/auth/login.dart';
import 'package:pawsome_client/screens/auth/sign_up_screen.dart';
import 'package:pawsome_client/screens/events/add_event.dart';
import 'package:pawsome_client/screens/events/event_screen.dart';
import 'package:pawsome_client/screens/forgot_password/forgot_password.dart';
import 'package:pawsome_client/screens/forgot_password/otp_verification.dart';
import 'package:pawsome_client/screens/forgot_password/reset_password.dart';
import 'package:pawsome_client/screens/home_screen.dart';
import 'package:pawsome_client/screens/onboard.dart';
import 'package:pawsome_client/screens/pet_management/Layout.dart';
import 'package:pawsome_client/screens/pet_management/home/pet_details.dart';
import 'package:pawsome_client/screens/pet_tracker/tracker/create_meal_plan.dart';
import 'package:pawsome_client/screens/pet_tracker/tracker/dashboard.dart';
import 'package:pawsome_client/screens/pet_tracker/tracker/tracker.dart';
import 'package:pawsome_client/services/pet.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/Onboard',
      builder: (BuildContext context, GoRouterState state) => const OnBoard(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) =>
          const SignUpScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => Layout(),
    ),
    GoRoute(
      path: '/analytics',
      builder: (BuildContext context, GoRouterState state) => Dashboard(),
    ),
    GoRoute(
      path: '/event',
      builder: (BuildContext context, GoRouterState state) =>
          const EventScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (BuildContext context, GoRouterState state) =>
              const AddEvent(),
        ),
      ],
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (BuildContext context, GoRouterState state) =>
          const ForgotPassword(),
      routes: [
        GoRoute(
          path: 'verify-otp',
          builder: (BuildContext context, GoRouterState state) =>
              const OtpPage(),
        ),
        GoRoute(
          path: 'reset-password',
          builder: (BuildContext context, GoRouterState state) =>
              const ResetPassword(),
        ),
      ],
    ),
    GoRoute(
      path: '/tracker',
      builder: (BuildContext context, GoRouterState state) =>
          Tracker(),
    ),
    GoRoute(
      path: '/tracker/meal/create',
      builder: (BuildContext context, GoRouterState state) =>
          const CreateMealPlan(),
    ),
    GoRoute(
        path: '/pet/details',
        builder: (BuildContext context, GoRouterState state) {
          dynamic petId = state.queryParameters['dynamicData'];

          return PetDetails(petId: petId);
        }),
  ],
  redirect: (context, state) async {
    final isViewed = await _checkViewedStatus();
    final isLoggedIn = await _checkAuth();
    final currentPath = state.location.toString();
    if (!isViewed) {
      return '/onboard';
    } else if (!isLoggedIn) {
      if (currentPath == '/signup') {
        return '/signup';
      } else if (currentPath == '/forgot-password' ||
          currentPath == '/forgot-password/verify-otp' ||
          currentPath == '/forgot-password/reset-password') {
        // Allow navigating to nested routes in the "forgot-password" route
        return currentPath;
      } else {
        return '/login';
      }
    } else {
      return currentPath;
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
