import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawsome_client/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9188e3)),
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      routerConfig: router,
    );
  }
}
