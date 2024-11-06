import 'package:flutter/material.dart';

//Light
const Color primary = Color(0xFFF3F3F3);
const Color white = Color(0xFFFFFFFF);
const Color red = Color(0xFFF24E1E);
const Color grey = Color(0xFFABABAB);
const Color grey2 = Color(0xFFD9D9D9);
const Color green = Color(0xFF089000);
const Color green2 = Color(0xFF15A70D);
const Color yellow = Color(0xFFC6A300);

//Dark
const Color primarydark = Color(0xFF000000);
const Color whitedark = Color(0xFF3D3D3D);
const Color reddark = Color(0xFFF24E1E);
const Color greydark = Color(0xFFABABAB);
const Color grey2dark = Color(0xFFD9D9D9);
const Color greendark = Color(0xFF089000);
const Color green2dark = Color(0xFF15A70D);
const Color yellowdark = Color(0xFFC6A300);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primary,
  scaffoldBackgroundColor: primary,
  colorScheme: const ColorScheme.light(
    primary: primary,
    onPrimary: white,
    secondary: primarydark,
    background: primarydark,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primarydark,
  scaffoldBackgroundColor: primarydark,
  colorScheme: const ColorScheme.dark(
    primary: primarydark,
    onPrimary: whitedark,
    secondary: white,
    background: grey,
  ),
);
