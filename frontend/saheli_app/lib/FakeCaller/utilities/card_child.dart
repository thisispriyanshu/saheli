import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardChild extends StatelessWidget {
  const CardChild({super.key, required this.onPress, required this.text, required this.imagePath});
  final String text;
  final String imagePath;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                imagePath,
                height: 160,
                width: 160,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.multiply,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
