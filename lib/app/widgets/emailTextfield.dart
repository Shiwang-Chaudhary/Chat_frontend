
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  const EmailTextField({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        }

        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      style: GoogleFonts.outfit(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        hintStyle: GoogleFonts.outfit(),
        prefixIcon: const Icon(
          Icons.email,
          color: Color.fromRGBO(54, 51, 136, 1),
          size: 30,
        ),
        hintText: "Enter your email ",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(7)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }
}
