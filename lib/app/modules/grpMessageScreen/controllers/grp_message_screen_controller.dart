import 'dart:io';

import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/cloudinary_service.dart';
import 'package:chat_backend/app/services/filePicker_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GrpMessageScreenController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  bool isOnline = true;
  late String? loggedUserId;
  final logger = Logger();
  late final IO.Socket socket;
  late String chatId;
  late String groupName;
  late List members;
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  RxBool isPageLoading = false.obs;
  RxBool isSendingMessageLoading = false.obs;
  FilePickerService filePickerService = FilePickerService();
  CloudinaryService cloudinaryService = CloudinaryService();
  @override
  void onInit() {
    // TODO: implement onInit
    groupName = Get.arguments["groupName"];
    members = Get.arguments["members"];
    chatId = Get.arguments["chatId"];
    logger.i("Group Name: $groupName");
    logger.i("Group members: $members");
    logger.i("Group Id: $chatId");
    getMessages();
    initializeSocket();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    messageController.dispose();
    if (socket.connected) {
      logger.i("👋 Leaving room: $chatId");
      socket.dispose();
    }
    super.onClose();
  }

  void initializeSocket() async {
    try {
      final token = await StorageService.getData("token");
      if (token == null || token.isEmpty) {
        return logger.e("❌ Token is NULL.");
      }
      socket = IO.io(
        "http://192.168.1.6:3000",
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .setAuth({"token": token.replaceAll("Bearer ", "")})
            .build(),
      );
      socket.connect();

      socket.onConnect((_) {
        logger.d("Socket connected: ${socket.id}");
        socket.emit("joinroom", chatId);
      });

      socket.on("receiveMessage", (data) {
        final Map<String, dynamic> receivedMessage = Map<String, dynamic>.from(
          data,
        );
        messages.add(receivedMessage);
        logger.i("RECEIVED MESSAGE: $messages");
      });

      socket.on("message_error", (error) {
        logger.e("❌ MESSAGE ERROR FROM SERVER: $error");
        Get.snackbar("Message failed", error.toString());
      });

      socket.on("chat_error", (error) {
        logger.e("❌ CHAT ERROR FROM SERVER: $error");
        Get.snackbar("Chat error", error.toString());
      });
      socket.on("member_error", (error) {
        logger.e("❌ Member ERROR FROM SERVER: $error");
        Get.snackbar("Chat error", error.toString());
      });

      socket.onDisconnect((data) {
        logger.w("❌ Socket disconnected");
      });

      socket.onConnectError((err) {
        logger.e("⚠ Socket connect error: $err");
      });
    } catch (e) {
      logger.e("Socket error: ${e.toString()}");
    }
  }

  void sendSocketMessage({
    String? chatId,
    String? messageType = "text",
    String? text,
    String? fileName,
    String? fileUrl,
    int? fileSize,
  }) {
    final msg = {
      "chatId": chatId ?? this.chatId,
      "text": text,
      "fileName": fileName,
      "fileUrl": fileUrl,
      "messageType": FilePickerService().getMessageType(fileName ?? ""),
      "fileSize": fileSize,
    };
    socket.emit("sendMessage", msg);
    messageController.clear();
  }

  void sendTextMessage() async {
    try {
      logger.d("Send message called");
      if (messageController.text.trim().isEmpty) return;
      final msg = {"chatId": chatId, "text": messageController.text.trim()};
      socket.emit("sendMessage", msg);
      messageController.clear();
    } catch (e) {
      logger.e("Error sending message: ${e.toString()}");
    }
  }

  void pickAndSendFileOrFiles() async {
    try {
      final List<File>? files = await filePickerService.pickMultipleFiles();
      if (files == null || files.isEmpty) return;
      if (files.length == 1) {
        logger.i("Uploading single file...");
        final singleFile = files.first;
        String fileUrl = await cloudinaryService.uploadFile(singleFile);
        final fileName = singleFile.path.split("/").last;
        final fileSize = await singleFile.length();
        sendSocketMessage(
          messageType: filePickerService.getMessageType(fileName),
          fileName: fileName,
          fileUrl: fileUrl,
          fileSize: fileSize,
        );
      } else {
        logger.i("Uploading multiple files...");
        for (var file in files) {
          final String fileUrl = await cloudinaryService.uploadFile(file);
          final fileName = file.path.split("/").last;
          final fileSize = await file.length();
          sendSocketMessage(
            messageType: filePickerService.getMessageType(fileName),
            fileName: fileName,
            fileUrl: fileUrl,
            fileSize: fileSize,
          );
        }
      }
    } catch (e) {
      logger.e("Error in picking or sending file(s): ${e.toString()}");
      Get.snackbar("File error", "Failed to send file(s). Please try again.");
    }
  }

  void pickAndSendImage() async {
    try {
      final image = await filePickerService.pickImage();
      if (image == null) return;
      String imageUrl = await cloudinaryService.uploadFile(image);
      final fileName = image.path.split("/").last;
      final fileSize = await image.length();
      sendSocketMessage(
        messageType: filePickerService.getMessageType(fileName),
        fileName: fileName,
        fileUrl: imageUrl,
        fileSize: fileSize,
      );
    } catch (e) {
      logger.e("Error in picking or sending image: ${e.toString()}");
      Get.snackbar("Image error", "Failed to send image. Please try again.");
    }
  }
  // void sendMessage() async {
  //   logger.i("SEND MESSAGE CALLED");
  //   try {
  //     isSendingMessageLoading.value = true;
  //     final msg = {"chatId": chatId, "text": messageController.text.trim()};
  //     if (messageController.text.isEmpty) {
  //       Get.snackbar("", "Please write a message first");
  //       logger.e("Please write a message first before sending it");
  //     }
  //     socket.emit("sendMessage", msg);
  //     logger.i("MESSAGE SENT: $msg");
  //     messageController.clear();
  //   } catch (e) {
  //     logger.e("Error in sending message:${e.toString()}");
  //   } finally {
  //     isSendingMessageLoading.value = false;
  //   }
  // }

  void getMessages() async {
    try {
      isPageLoading.value = true;
      loggedUserId = await StorageService.getData("id");
      final token = await StorageService.getData("token");
      final body = await ApiService.get(
        "${ApiEndpoints.getMessage}/$chatId",
        token,
      );
      final List<Map<String, dynamic>> messageList =
          List<Map<String, dynamic>>.from(body["data"]);
      logger.i("GetMessage data: $messageList");
      messages.assignAll(messageList);
      logger.i("MESSAGE LIST data: $messages");
      logger.i("Total message: ${messages.length}");
    } catch (e) {
      logger.e("Error in getting message:${e.toString()}");
    } finally {
      isPageLoading.value = false;
    }
  }

  String formatDateTime(String isoTime) {
    final DateTime dateTime = DateTime.parse(isoTime).toLocal();
    final int day = dateTime.day;
    final int month = dateTime.month;
    final int year = dateTime.year;
    final int hour = dateTime.hour;
    final int minute = dateTime.minute;
    final String period = hour >= 12 ? "PM" : "AM";
    final int formattedHour = hour == 0
        ? 12
        : hour > 12
        ? hour - 12
        : hour;
    final String formattedMinute = minute.toString().padLeft(2, '0');
    return "$day/$month/$year  $formattedHour:$formattedMinute $period";
  }
}
