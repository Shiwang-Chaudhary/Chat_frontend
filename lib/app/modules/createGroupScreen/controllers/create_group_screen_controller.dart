import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CreateGroupScreenController extends GetxController {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final RxList<Map<String, dynamic>> searchedUsers =
      <Map<String, dynamic>>[].obs;
  final RxList<String> selectedMembersId = <String>[].obs;
  late String? chatId;
  final logger = Logger();

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
    final body =
        await ApiService.get("${ApiEndpoints.searchUsers}?query=$text", token);
    final List data = body["data"];
    logger.i("SearchUser DATA: $data");
    searchedUsers.clear();
    searchedUsers.assignAll(data.cast<Map<String, dynamic>>());
    // logger.i("SearchUser List: $searchedUsers");
  }

  void createGroup() async {
    final token = await StorageService.getData("token");
    if (groupNameController.text.isNotEmpty) {
      
    
    final body = await ApiService.post(
        {"name": groupNameController.text.trim(), "members": selectedMembersId},
        ApiEndpoints.createGroupChat,
        token: token);
    logger.i("Create group data: $body");
    Get.back(
      result: true
    );
    }else{
      logger.e("Please enter the group name");
      Get.snackbar("Error", "Please add the group name");
    }
  }

  @override
  void onClose() {
    groupNameController.dispose();
    super.onClose();
  }
}
