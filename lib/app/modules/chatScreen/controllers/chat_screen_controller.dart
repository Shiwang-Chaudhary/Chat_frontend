import 'dart:convert';
import 'dart:io';
import 'package:chat_backend/app/services/cloudinary_service.dart';
import 'package:chat_backend/app/services/filePicker_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ChatScreenController extends GetxController {
  late String? loggedUserId;
  final bool isOnline = true;
  late final String otherUserId;
  late final String otherUserName;
  late final String chatId;
  final TextEditingController messageController = TextEditingController();
  var logger = Logger();
  final RxList messages = [].obs;
  late final IO.Socket socket;
  CloudinaryService cloudinaryService = CloudinaryService();
  FilePickerService filePickerService = FilePickerService();
  RxBool isLoading = true.obs;
  RxBool isSendingFile = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    otherUserId = Get.arguments["otherUserId"];
    chatId = Get.arguments["chatId"];
    otherUserName = Get.arguments["otherUserName"];
    initializeSocket();
    getMessages();
    logger.i("ChatId: $chatId");
    logger.i("Other User Id: $otherUserName");
    logger.i("Other User Id: $otherUserId");
  }

  @override
  void onClose() {
    messageController.dispose();
    if (socket.connected) {
      logger.i("👋 Leaving room: $chatId");
      socket.dispose();
    }
    super.onClose();
  }

  void initializeSocket() async {
    final token = await StorageService.getData("token");
    if (token == null || token.isEmpty) {
      logger.e("❌ Token is NULL.");
      return;
    }
    socket = IO.io(
      "http://192.168.1.11:3000",
      // "https://shiwang-chat-backend.onrender.com",
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
      final Map<String, dynamic> map = Map<String, dynamic>.from(data);
      // messages.add(map);
      messages.insert(0, map);
      messages.refresh();
      logger.i("New message received: $data");
    });

    socket.onDisconnect((_) {
      logger.w("❌ Socket disconnected");
    });

    socket.onConnectError((err) {
      logger.e("⚠ Socket connect error: $err");
    });
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
      final msg = {
        "chatId": chatId,
        "text": messageController.text.trim(),
        "messageType": "text",
      };
      socket.emit("sendMessage", msg);
      messageController.clear();
    } catch (e) {
      logger.e("Error sending message: ${e.toString()}");
    }
  }

  // void pickAndSendFileOrFiles() async {
  //   try {
  //     final List<File>? files = await filePickerService.pickMultipleFiles();
  //     if (files == null || files.isEmpty) {
  //       isSendingFile.value = false;
  //       return;
  //     }
  //     if (files.length == 1) {
  //       logger.i("Uploading single file...");
  //       final singleFile = files.first;
  //       String fileUrl = await cloudinaryService.uploadFile(singleFile);
  //       final fileName = singleFile.path.split("/").last;
  //       final fileSize = await singleFile.length();
  //       sendSocketMessage(
  //         messageType: filePickerService.getMessageType(fileName),
  //         fileName: fileName,
  //         fileUrl: fileUrl,
  //         fileSize: fileSize,
  //       );
  //     } else {
  //       logger.i("Uploading multiple files...");
  //       for (var file in files) {
  //         final String fileUrl = await cloudinaryService.uploadFile(file);
  //         final fileName = file.path.split("/").last;
  //         final fileSize = await file.length();
  //         sendSocketMessage(
  //           messageType: filePickerService.getMessageType(fileName),
  //           fileName: fileName,
  //           fileUrl: fileUrl,
  //           fileSize: fileSize,
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     logger.e("Error in picking or sending file(s): ${e.toString()}");
  //     Get.snackbar("File error", "Failed to send file(s). Please try again.");
  //   }
  // }

  // void pickAndSendImage() async {
  //   try {
  //     final image = await filePickerService.pickImage();
  //     if (image == null) return;
  //     String imageUrl = await cloudinaryService.uploadFile(image);
  //     final fileName = image.path.split("/").last;
  //     final fileSize = await image.length();
  //     sendSocketMessage(
  //       messageType: filePickerService.getMessageType(fileName),
  //       fileName: fileName,
  //       fileUrl: imageUrl,
  //       fileSize: fileSize,
  //     );
  //   } catch (e) {
  //     logger.e("Error in picking or sending image: ${e.toString()}");
  //     Get.snackbar("Image error", "Failed to send image. Please try again.");
  //   }
  // }
  void pickAndSendFileOrFiles() async {
    try {
      final List<File>? files = await filePickerService.pickMultipleFiles();
      if (files == null || files.isEmpty) return;
      if (files.length == 1) {
        isSendingFile.value = true;
        await Future.delayed(const Duration(milliseconds: 50));
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
    } finally {
      isSendingFile.value = false;
    }
  }

  void pickAndSendImage() async {
    try {
      final image = await filePickerService.pickImage();
      isSendingFile.value = true;
      if (image == null) {
        isSendingFile.value = false;
        return;
      }
      await Future.delayed(const Duration(milliseconds: 100));
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
    } finally {
      isSendingFile.value = false;
    }
  }

  void getMessages() async {
    final String? token = await StorageService.getData("token");
    loggedUserId = await StorageService.getData("id");
    final response = await ApiService.get(
      "${ApiEndpoints.getMessage}/$chatId",
      token,
    );

    final List<Map<String, dynamic>> messageList =
        List<Map<String, dynamic>>.from(response["data"]);
    logger.i("Fetched Messages: ${jsonEncode(messageList)}");
    messages.clear(); //SO THAT OLD MESSAGES ARE REMOVED BEFORE ADDING NEW ONES
    messages.addAll(messageList.reversed.toList());

    logger.i("MESSAGES LOADED: ${messages.length}");
    isLoading.value = false;
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
