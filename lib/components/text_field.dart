import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double borderRadius;
  final IconData icon;
  final double iconPadding;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.borderRadius = 5.0,
    required this.icon,
    this.iconPadding = 10.0, // Default icon padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        fillColor: Colors.grey[200],
        filled: true,
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(color: Colors.grey[400]),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(iconPadding),
          child: Icon(icon),
        ),
      ),
    );
  }
}
