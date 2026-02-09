import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/messageContainer.dart';
import 'package:chat_backend/app/widgets/messageTextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_screen_controller.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  const ChatScreenView({super.key});

  // 🔹 ISO → "DD/MM/YYYY  hh:mm AM/PM"

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Get.back(result: true);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF2B2B49),
        appBar: AppBar(
          backgroundColor: const Color(0xFF24243E),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: CapitalizeService.capitalizeEachWord(
                  controller.otherUserName,
                ),
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
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
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
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final Map data = controller.messages[index];
                    final String message = data["content"] ?? "";
                    final Map sender = data["sender"];
                    final String senderId = sender["_id"];
                    final bool isMe = senderId == controller.loggedUserId;
                    final String createdAt = data["createdAt"];
                    final String fileType = data["messageType"] ?? "text";
                    final String fileUrl = data["fileUrl"] ?? "";
                    final String videoThumbnailUrl = fileUrl.replaceAll(
                      RegExp(r'\.(mp4|mov|pdf|doc|docx)$'),
                      ".jpeg",
                    );
                    final String fileName = data["fileName"] ?? "";
                    final int fileSize = data["fileSize"] ?? 0;
                    final String dateTime = controller.formatDateTime(
                      createdAt,
                    );
                    controller.logger.i("FileUrl : $fileUrl");
                    controller.logger.i("FileType : $fileType");
                    controller.logger.i("MESSAGE : $message");
                    controller.logger.i(
                      "otherName : ${controller.otherUserName}",
                    );
                    controller.logger.i("THumbnail URL: $videoThumbnailUrl");
                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: MessageContainer(
                        isFile: true,
                        isMe: isMe,
                        message: message,
                        dateTime: dateTime,
                        fileType: fileType,
                        fileUrl: fileUrl,
                        fileName: fileName,
                        fileSize: fileSize,
                        otherName: controller.otherUserName,
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
      ),
    );
  }
}
