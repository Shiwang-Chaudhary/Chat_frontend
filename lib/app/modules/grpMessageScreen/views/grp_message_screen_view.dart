import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/messageContainer.dart';
import 'package:chat_backend/app/widgets/messageTextfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/grp_message_screen_controller.dart';

class GrpMessageScreenView extends GetView<GrpMessageScreenController> {
  const GrpMessageScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF24243E),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ElevatedButton(onPressed: (){
            //   controller.getMessages();
            // }, child: CustomText(text: "TEST BUTTON")),
            CustomText(
              text: CapitalizeService.capitalizeEachWord(controller.groupName),
              size: 20,
              color: Colors.white,
            ),
            // CustomText(
            //   text: controller.isOnline ? "Online" : "Offline",
            //   size: 13,
            //   color: Colors.greenAccent,
            // ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF24243E),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final data = controller.messages[index];
                  final message = data["content"];
                  final senderId = data["sender"]["_id"];
                  final senderName = data["sender"]["name"];
                  final createdAt = data["createdAt"];
                  final dateTime = controller.formatDateTime(createdAt);
                  controller.logger.i("Data LIST:$data");
                  controller.logger.i("SENDER NAME:$senderName");
                  final bool isMe = senderId == controller.loggedUserId;
                  final fileType = data["messageType"];
                  final fileUrl = data["fileUrl"];
                  final fileName = data["fileName"];
                  final fileSize = data["fileSize"];
                  // final String videoThumbnailUrl = fileUrl.replaceAll(
                  //   RegExp(r'\.(mp4|mov|pdf|doc|docx)$'),
                  //   ".jpeg",
                  // );
                  controller.logger.i("fileType :$fileType");
                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: MessageContainer(
                      isFile: true,
                      isMe: isMe,
                      otherName: senderName,
                      message: message,
                      dateTime: dateTime,
                      fileType: fileType,
                      fileUrl: fileUrl,
                      fileName: fileName,
                      fileSize: fileSize,
                      // videoThumbnailUrl: videoThumbnailUrl,
                    ),
                  );
                },
              ),
            ),
          ),
          MessageTextfield(controller: controller),
        ],
      ),
    );
  }
}
