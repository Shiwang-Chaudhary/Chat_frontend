import 'package:bounce/bounce.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';

class CustomLargeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? size;
  final Color? textColor;
  final FontWeight? weight;
  final Color? buttonColor;
  const CustomLargeButton({
    super.key,
    required this.onTap,
    required this.text,
    this.size,
    this.textColor,
    this.weight,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 120),
      onTap: onTap,
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
              color: buttonColor ?? Colors.white,
              borderRadius: BorderRadius.circular(12)),
          child: CustomText(
            text: text,
            size: size ?? 19,
            color: textColor ?? Colors.blueAccent,
            weight: weight ?? FontWeight.w500,
          )),
    );
  }
}