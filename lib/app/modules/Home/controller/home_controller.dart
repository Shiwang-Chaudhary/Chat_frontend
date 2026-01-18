import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

//token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NmJiYmU4M2MzMWZkMDI1N2RiNzljMyIsImVtYWlsIjoic2hpd2FuZ0BnbWFpbC5jb20iLCJpYXQiOjE3Njg2NzA3OTYsImV4cCI6MTc3MTI2Mjc5Nn0.kyPN8lQ9yvffEjF3TWgEbmlLRdMpq0dwhTeIguYwlHY";
class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<String> chatIDs = <String>[].obs;
  RxList chats = [].obs;
  String? loggedUserId = "";
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getLoggedUserId();
    getChats();
  }

  void getLoggedUserId() async {
    loggedUserId = await StorageService.getData("id");
  }

  String capitalizeEachWord(String text) {
    return text
        .split(' ')
        .map((word) =>
            word.isEmpty ? word : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void getChats() async {
    final token = await StorageService.getData("token");
    print("LOGGED USER ID :$loggedUserId");
    final Map response = await ApiService.get(ApiEndpoints.getAllChats,
        token
        //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5NmJiYmU4M2MzMWZkMDI1N2RiNzljMyIsImVtYWlsIjoic2hpd2FuZ0BnbWFpbC5jb20iLCJpYXQiOjE3Njg2NzA3OTYsImV4cCI6MTc3MTI2Mjc5Nn0.kyPN8lQ9yvffEjF3TWgEbmlLRdMpq0dwhTeIguYwlHY"
        );
    final data = response["data"];
    chats.assignAll(data);
    for (var chat in data) {
      chatIDs.add(chat["_id"]);
      //print("MODIFIED CHAT:${chat["_id"]}");
    }
    print("CHAT IDs LIST:$chatIDs");
    // print("Modified data: ${for(){}}");
    // chats.addAll(data[])
    // print("CHATS:$data");
    print("CHATS:$chats");
  }
}
