import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTextfield.dart';
import 'package:chat_backend/app/widgets/customTile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_screen_controller.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  const ChatScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Chats",
          size: 23,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF24243E),
        centerTitle: true,
      ),
      body: Center(child: CustomText(text: "WORKING"),),
    );
  }
}
