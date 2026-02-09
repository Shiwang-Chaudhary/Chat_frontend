import 'dart:developer';

import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NmJiYmU4M2MzMWZkMDI1N2RiNzljMyIsImVtYWlsIjoic2hpd2FuZ0BnbWFpbC5jb20iLCJpYXQiOjE3Njg2NzA3OTYsImV4cCI6MTc3MTI2Mjc5Nn0.kyPN8lQ9yvffEjF3TWgEbmlLRdMpq0dwhTeIguYwlHY";
class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<String> chatIDs = <String>[].obs;
  RxList chats = [].obs;
  String? loggedUserId = "";
  RxBool isLoading = true.obs;
  @override
  void onInit() async {
    super.onInit();
    getLoggedUserId();
    getChats();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void getLoggedUserId() async {
    loggedUserId = await StorageService.getData("id");
  }

  void getChats() async {
    final token = await StorageService.getData("token");
    log("LOGGED USER ID :$loggedUserId");
    final Map response = await ApiService.get(ApiEndpoints.getAllChats, token);
    final data = response["data"];
    chats.assignAll(data);
    for (var chat in data) {
      chatIDs.add(chat["_id"]);
    }
    log("CHAT IDs LIST:$chatIDs");
    log("CHATS:$chats");
    isLoading.value = false;
  }
}
