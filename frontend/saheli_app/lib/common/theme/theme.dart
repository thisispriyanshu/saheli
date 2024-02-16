import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles{
  static ThemeData themeData(BuildContext){
    return ThemeData(
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: Color(0xffffecd0),
        secondary: Color(0xffff3974)
      ),
      fontFamily:  GoogleFonts.montserrat().fontFamily,
    );
  }
}