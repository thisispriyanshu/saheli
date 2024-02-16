import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconContent extends StatelessWidget {
  IconContent({required this.icon, required this.text});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80.0,
          color: const Color.fromARGB(255, 255, 236, 208),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          text,
          style: GoogleFonts.lato(),
        ),
      ],
    );
  }
}
