import 'package:chat_backend/app/modules/chatScreen/controllers/chat_screen_controller.dart';
import 'package:chat_backend/app/modules/chatScreen/views/chat_screen_view.dart';
import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SearchUserScreenController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList users = [].obs;
  late String? chatId;
  final logger = Logger();
  @override
  void onClose() {
    // TODO: implement onClose
    searchController.dispose();
    super.onClose();
  }

  void seachUsers(String text) async {
    final String? token = await StorageService.getData("token");
    final query = text.trim();
    if (query.isEmpty) {
      users.clear();
      return;
    }
    final body = await ApiService.get(
      "${ApiEndpoints.searchUsers}?query=$text",
      token,
    );
    final List data = body["data"];
    logger.i("SearchUser DATA: $data");
    users.clear();
    users.addAll(data);
  }

  void createOrGetChatRoom(String userId, String userName) async {
    final token = await StorageService.getData("token");
    final responseBody = await ApiService.post(
      {"userId": userId},
      ApiEndpoints.createOrGetChatRoom,
      token: token,
    );

    chatId = responseBody["Chat"]["_id"];
    logger.i("ChatId: $chatId");
    logger.i("CreateOrGetChatRoom: $responseBody");
    if (chatId != null) {
      final result = await Get.to(
        () => ChatScreenView(),
        binding: BindingsBuilder(() {
          Get.put(ChatScreenController());
        }),
        arguments: {
          "chatId": chatId,
          "otherUserName": userName,
          "otherUserId": userId,
        },
      );
      if (result == true) {
        Get.back(result: true);
      }
    }
  }
}
