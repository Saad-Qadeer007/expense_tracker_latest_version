import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'App_Colors.dart';

class AppThemes {
  ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme,
    ).apply(bodyColor: Colors.black, displayColor: Colors.black),
    cardColor: AppColors.card,
    iconTheme: IconThemeData(color: Colors.black),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: AppColors.background,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primary,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: TextStyle(color: Colors.grey),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
  );
  ThemeData darkTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: Colors.white, displayColor: Colors.white),
    cardColor: AppColors.darkCard,
    iconTheme: IconThemeData(color: Colors.white),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: TextStyle(color: Colors.grey),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.grey.shade900,
      titleTextStyle: TextStyle(color: Colors.white),
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}
