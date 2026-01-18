import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/messageContainer.dart';
import 'package:chat_backend/app/widgets/messageTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_screen_controller.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  const ChatScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2B49),

      // 🔹 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF24243E),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: controller.otherUserName,
              size: 20,
              color: Colors.white,
            ),
            CustomText(
              text: controller.isOnline ? "Online" : "Offline",
              size: 13,
              color: Colors.greenAccent,
            ),
          ],
        ),
      ),

      // 🔹 BODY
      body: Column(
        children: [
          // 🔹 CHAT MESSAGES
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final bool isMe =
                      message["senderId"] == controller.loggedUserId;

                  return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: MessageContainer(isMe: isMe, message: message));
                },
              ),
            ),
          ),

          // 🔹 MESSAGE INPUT
          MessageTextfield(controller: controller)
        ],
      ),
    );
  }
}
