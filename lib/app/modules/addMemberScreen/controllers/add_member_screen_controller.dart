import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AddMemberScreenController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<Map<String, dynamic>> searchedUsers =
      <Map<String, dynamic>>[].obs;
  final RxList<String> selectedMembersId = <String>[].obs;
  late String chatId;
  late List members;
  late Map admin;

  final logger = Logger();
  @override
  void onInit() {
    members = Get.arguments["members"];
    chatId = Get.arguments["chatId"];
    admin = Get.arguments["admin"];
    logger.i("AdminInfo: $admin");
    logger.i("ChatId: $chatId");
    logger.i("MembersInfo after sorting from previousScreen: $members");
    super.onInit();
  }

  void toggleUserSelection(String userId) async {
    logger.i("toggleUserSelection Called");
    if (selectedMembersId.contains(userId)) {
      selectedMembersId.remove(userId);
      logger.i("Selected member list: $selectedMembersId");
    } else {
      selectedMembersId.add(userId);
      logger.i("Selected member list: $selectedMembersId");
    }
  }

  void seachUsers(String text) async {
    final String? token = await StorageService.getData("token");
    final query = text.trim();
    if (query.isEmpty) {
      searchedUsers.clear();
      return;
    }
    final body = await ApiService.get(
      "${ApiEndpoints.searchUsers}?query=$text",
      token,
    );
    final List data = body["data"];
    logger.i("SearchUser DATA: $data");
    searchedUsers.clear();
    searchedUsers.assignAll(data.cast<Map<String, dynamic>>());
    // logger.i("SearchUser List: $searchedUsers");
  }

  void addMembers() async {
    final token = await StorageService.getData("token");
    final responseBody = await ApiService.patch(
      {"chatId": chatId, "members": selectedMembersId},
      ApiEndpoints.addMembers,
      token: token,
    );
    logger.i("Add member responseBody:$responseBody");
    Get.back(result: true);
  }
}
