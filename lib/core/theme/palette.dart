import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pallete {
  // Colors
  static const patricksBlue = Color(0xFF1F2970);
  static const sapphire = Color(0xFF0D50AB);
  static const mediumPurple = Color(0xFF7C83FD);
  static const azure = Color(0xFF1E7AF5);
  static const frenchPink = Color(0xFFFF5D8F);
  static const goGreen = Color(0xFF12AE67);
  static const yellowRed = Color(0xFFFFCA60);
  static const bgColor = Color(0xFFF7F8F9);
  static const bgDarkColor = Color(0xFF232931);
  static const primaryDarkColor = Color(0xFF393E46);
  static const buttonColor = Color(0xFF6F35A5);

  // Themes
/*   static var darkModeAppTheme = ThemeData.dark().copyWith(
    textTheme: GoogleFonts.montserratTextTheme(),
    scaffoldBackgroundColor: Pallete.bgDarkColor,
    bottomAppBarColor: primaryDarkColor,
    cardColor: Pallete.primaryDarkColor,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      prefixIconColor: Colors.white,
    ),
    backgroundColor: bgDarkColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.primaryDarkColor,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.primaryDarkColor,
      foregroundColor: Colors.white,
    ),
    primaryColor: Colors.white,
  );
 */
  static var lightModeAppTheme = ThemeData.light().copyWith(
    chipTheme: const ChipThemeData(backgroundColor: Colors.white),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      prefixIconColor: Pallete.goGreen,
    ),
    backgroundColor: Pallete.bgColor,
    bottomAppBarColor: Colors.white,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Pallete.bgColor,
    primaryColor: Pallete.goGreen,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.goGreen,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.goGreen,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Pallete.bgColor,
    ),
  );
}
