import 'dart:developer';

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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    otherUser = Get.arguments["otherUser"];
    chatId = Get.arguments["chatId"];
    otherUserId = otherUser["_id"];
    otherUserName = otherUser["name"];
    getMessages();
    logger.i("ChatId: $chatId");
    logger.i("Other User: $otherUser");
    logger.i("Other User Id: $otherUserId");
  }

  void sendMessage() async {
    log("Send message called");
    final String? token = await StorageService.getData("token");
    if (messageController.text.trim().isEmpty) return;
    final response = await ApiService.post(
      {"chatId": chatId, "content": messageController.text.trim()},
      ApiEndpoints.sendMessage,
      token: token,
    );
    log("SEND MESSAGE RESPONSE: $response");
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
