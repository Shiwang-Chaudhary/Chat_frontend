import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  final bool isMe;
  final String message;
  final String dateTime;

  const MessageContainer({
    super.key,
    required this.isMe,
    required this.message,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 260),
      decoration: BoxDecoration(
        color: isMe ? Colors.blueAccent : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          CustomText(text: message, color: Colors.white, size: 15),
          const SizedBox(height: 4),
          CustomText(text: dateTime, color: Colors.white70, size: 11),
        ],
      ),
    );
  }
}
