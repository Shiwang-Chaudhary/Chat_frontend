import 'package:chat_backend/app/routes/app_routes.dart';
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
        title: GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.GRP_INFOTAB,
              arguments: {
                "members": controller.membersInfo,
                "admin": controller.adminInfo,
                "groupName": controller.groupName,
                "chatId": controller.chatId,
              },
            );
          },
          child: CustomText(
            text: CapitalizeService.capitalizeEachWord(controller.groupName),
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(43, 43, 72, 1),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isPageLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              }
              if (controller.isSendingFile.value == true) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Uploading...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (controller.messages.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: "No messages yet. Start the conversation!",
                    size: 16,
                    color: Colors.white54,
                  ),
                );
              }

              return ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final data = controller.messages[index];
                  final message = data["content"];
                  final senderId = data["sender"]["_id"];
                  final senderName = data["sender"]["name"];
                  final createdAt = data["createdAt"];
                  final dateTime = controller.formatDateTime(createdAt);
                  // controller.logger.i("Data LIST:$data");
                  // controller.logger.i("SENDER NAME:$senderName");
                  final bool isMe = senderId == controller.loggedUserId;
                  final fileType = data["messageType"];
                  final fileUrl = data["fileUrl"];
                  final fileName = data["fileName"];
                  final fileSize = data["fileSize"];
                  final String? videoThumbnailUrl = fileUrl == null
                      ? ""
                      : fileUrl.replaceAll(
                          RegExp(r'\.(mp4|mov|pdf|doc|docx)$'),
                          ".jpeg",
                        );
                  // controller.logger.i("fileType :$fileType");
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
                      videoThumbnailUrl: videoThumbnailUrl,
                    ),
                  );
                },
              );
            }),
          ),
          MessageTextfield(controller: controller),
        ],
      ),
    );
  }
}
