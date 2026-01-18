import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  final bool isMe;
  final Map message;
  const MessageContainer(
      {super.key, required this.isMe, required this.message});

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
      child: CustomText(
        text: message["content"],
        color: Colors.white,
        size: 15,
      ),
    );
  }
}
