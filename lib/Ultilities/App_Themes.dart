import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  );
  ThemeData darkTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  );
}
