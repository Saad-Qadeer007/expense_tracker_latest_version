import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'App_Colors.dart';

class AppThemes {
  ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme,
    ).apply(bodyColor: Colors.black, displayColor: Colors.black),
    cardColor: AppColors.card,
  );
  ThemeData darkTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: Colors.white, displayColor: Colors.white),
    cardColor: AppColors.darkCard,
  );
}
