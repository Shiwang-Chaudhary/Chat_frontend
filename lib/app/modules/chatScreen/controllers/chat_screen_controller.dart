import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ChatScreenController extends GetxController {
  late String? loggedUserId = "USER_1";
  final bool isOnline = true;
  // final Map otherUser = Get.arguments["otherUser"];
  late final Map otherUser;
  late final String otherUserId;
  late final String otherUserName;
  late final String chatId;
  final TextEditingController messageController = TextEditingController();
  var logger = Logger();
  final RxList messages = [].obs;
  late final IO.Socket socket;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    otherUser = Get.arguments["otherUser"];
    chatId = Get.arguments["chatId"];
    otherUserId = otherUser["_id"];
    otherUserName = otherUser["name"];
    initializeSocket();
    getMessages();
    logger.i("ChatId: $chatId");
    logger.i("Other User: $otherUser");
    logger.i("Other User Id: $otherUserId");
  }

  void initializeSocket() async {
    final token = await StorageService.getData("token");
    if (token == null || token.isEmpty) {
      logger.e("❌ Token is NULL. Socket will fail auth.");
      return;
    }
    socket = IO.io(
      "http://192.168.1.15:3000",
      IO.OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .setAuth({"token": token.replaceAll("Bearer ", "")}) // 👈 FIXED
          .build(),
    );
    socket.connect();

    socket.onConnect((_) {
      logger.i("Socket connected: ${socket.id}");
      socket.emit("joinroom", chatId);
    });
    socket.on("receiveMessage", (data) {
      final Map<String, dynamic> map = Map<String, dynamic>.from(
        data,
      ); // 👈 SAFE
      messages.add(map);
      logger.i("New message received: $data");
    });
    socket.onDisconnect((_) {
      logger.w("❌ Socket disconnected");
    });

    socket.onConnectError((err) {
      logger.e("⚠ Socket connect error: $err");
    });
  }

  void sendMessage() async {
    log("Send message called");
    // final String? token = await StorageService.getData("token");
    if (messageController.text.trim().isEmpty) return;
    final msg = {"chatId": chatId, "text": messageController.text.trim()};

    socket.emit("sendMessage", msg);
    // final response = await ApiService.post(
    //   {"chatId": chatId, "content": messageController.text.trim()},
    //   ApiEndpoints.sendMessage,
    //   token: token,
    // );
    // log("SEND MESSAGE RESPONSE: $response");
    messageController.clear();
  }

  void getMessages() async {
    final String? token = await StorageService.getData("token");
    loggedUserId = await StorageService.getData("id");
    final response = await ApiService.get(
      "${ApiEndpoints.getMessage}/$chatId",
      token,
    );

    final List messageList = response["data"];
    logger.i("Fetched Messages: $messageList");
    messages.clear(); //SO THAT OLD MESSAGES ARE REMOVED BEFORE ADDING NEW ONES
    messages.addAll(messageList.cast<Map<String, dynamic>>());

    log("MESSAGES LOADED: ${messages.length}");
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

  String formatTime(String isoTime) {
    final DateTime dateTime = DateTime.parse(isoTime).toLocal();

    final int hour = dateTime.hour;
    final int minute = dateTime.minute;

    final String period = hour >= 12 ? "PM" : "AM";
    final int formattedHour = hour == 0
        ? 12
        : hour > 12
        ? hour - 12
        : hour;

    final String formattedMinute = minute.toString().padLeft(2, '0');

    return "$formattedHour:$formattedMinute $period";
  }
}
