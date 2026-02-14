import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:flutter/material.dart';

class FriendMarker extends StatelessWidget {
  final String name;

  const FriendMarker({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Center(
        child: Text(
          CapitalizeService.capitalizeEachWord(name), // first letter
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
