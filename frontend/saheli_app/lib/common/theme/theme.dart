import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles{
  static ThemeData themeData(BuildContext context){
    return ThemeData(
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        // primary: Color(0xffffecd0),
        // secondary: Color(0xffFF6978),
        // tertiary: Color(0xff38302E),
        primary: Color(0xffFD6978),
        secondary: Color(0xffFCF3E8),
        tertiary: Color(0xffF0F0F0),
      ),
      fontFamily:  "font",
      elevatedButtonTheme:ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFD6978),
          //side: BorderSide(color: Color(0xffFCF3E8), width: 0.5)
        )
      )
    );
  }
}