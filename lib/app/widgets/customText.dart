import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final int? maxLines;
  final Color? color;
  final TextOverflow? overflow;
  const CustomText({super.key,
  required this.text,
   this.maxLines,
   this.color,
   this.overflow,
   this.size,
   this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow??TextOverflow.ellipsis,
      softWrap: true,
      style: GoogleFonts.outfit(
          height: 1.3,
          letterSpacing: 1,
          fontSize: size ?? 16,
          fontWeight: weight ?? FontWeight.w400,
          color: color ?? Colors.black,
      ));
  }
}