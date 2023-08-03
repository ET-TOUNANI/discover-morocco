import 'package:discover_morocco/business_logic/models/models/enums/brightness.dart';
import 'package:flutter/material.dart';

class Themes {
  static const kWhiteText = TextStyle(
    fontFamily: "manrope",
    color: Colors.white,
  );
  static const kBlackText = TextStyle(
    fontFamily: "manrope",
    color: Colors.black,
  );

  static const Color backgroundChatQuestion = Colors.white;
  static const Color backgroundChatAnswer = Color(0xffDCF6E6);
  static const BoxDecoration backgroundColor = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 40, 228, 227),
          Color.fromARGB(255, 20, 125, 183)
        ]),
  );
  static const BoxDecoration backgroundAppBare = BoxDecoration(
    borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 20, 125, 183),
          Color.fromARGB(255, 40, 228, 227),
        ]),
  );
  /*List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];*/
  ThemeData get darkBrightness => ThemeData(
        fontFamily: "manrope",
        primarySwatch: const MaterialColor(
          0xFFffab40, // primaryColor
          <int, Color>{
            50: Color(0xFFFFF5E8),
            100: Color(0xFFFFE6C6),
            200: Color(0xFFFFD5A0),
            300: Color(0xFFFFC479),
            400: Color(0xFFFFB85D),
            500: Color(0xFFffab40), // primaryColor
            600: Color(0xFFFFA43A),
            700: Color(0xFFFF9A32),
            800: Color(0xFFFF912A),
            900: Color(0xFFFF801C),
          },
        ),
      );

  ThemeData get lightBrightness => ThemeData(
        fontFamily: "manrope",
        primarySwatch: const MaterialColor(
          0xFFffab40, // primaryColor
          <int, Color>{
            50: Color(0xFFFFF5E8),
            100: Color(0xFFFFE6C6),
            200: Color(0xFFFFD5A0),
            300: Color(0xFFFFC479),
            400: Color(0xFFFFB85D),
            500: Color(0xFFffab40), // primaryColor
            600: Color(0xFFFFA43A),
            700: Color(0xFFFF9A32),
            800: Color(0xFFFF912A),
            900: Color(0xFFFF801C),
          },
        ),
      );

  ThemeData getBrightness(MoreBrightness moreBrightness) {
    final brightness = moreBrightness == MoreBrightness.systemDefault
        ? MediaQueryData.fromView(WidgetsBinding.instance.window)
            .platformBrightness
        : Brightness.values.byName(moreBrightness.name);

    if (brightness == Brightness.dark) return darkBrightness;
    return lightBrightness;
  }
}
