import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  String hint;
  final TextEditingController controller;
  bool isInputTypeString;
  Color color;
  bool enabled;
  CustomTextFormField({super.key, required this.hint, required this.controller, required this.color, this.isInputTypeString = true, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isInputTypeString ? TextInputType.text : TextInputType.number,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      enabled: enabled,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      maxLines: 1,
      cursorColor: color,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: Colors.black.withOpacity(0.20000000298023224),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
