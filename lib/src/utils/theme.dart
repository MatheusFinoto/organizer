import 'package:flutter/material.dart';

const Color blue800 = Color(0xff012030);
const Color blue500 = Color(0xff13678A);
const Color blue100 = Color(0xff45C4B0);
const Color green200 = Color(0xff9AEBA3);
const Color green100 = Color(0xffDAFDBA);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: blue800,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  primaryColor: blue500,
  primaryColorLight: blue500,
  // textTheme: const TextTheme(
  //   bodySmall: TextStyle(
  //       fontSize: 8, fontWeight: FontWeight.w400, color: Colors.white70),
  //   bodyMedium: TextStyle(
  //       fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white),
  //   bodyLarge: TextStyle(
  //       fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
  //   headlineSmall: TextStyle(
  //       fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  //   headlineMedium: TextStyle(
  //       fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
  //   headlineLarge: TextStyle(
  //       fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
  // )
);
