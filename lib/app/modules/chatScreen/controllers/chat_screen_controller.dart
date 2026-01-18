import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  final String loggedUserId = "USER_1";
  final String otherUserName = "Aditya";
  final bool isOnline = true;

  final TextEditingController messageController = TextEditingController();

  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[
    {
      "senderId": "USER_1",
      "content": "Hey 👋",
    },
    {
      "senderId": "USER_2",
      "content": "Hi! How are you?",
    },
    {
      "senderId": "USER_1",
      "content": "I am good, working on chat app 😄",
    },
  ].obs;

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messages.add({
      "senderId": loggedUserId,
      "content": messageController.text.trim(),
    });

    messageController.clear();
  }
}
