import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CreateGroupScreenController extends GetxController {
  final TextEditingController groupNameController = TextEditingController();
    final TextEditingController searchController = TextEditingController();
  RxList searchedUsers = [].obs;
  late String? chatId;
  final logger = Logger();
  var isSelected = false.obs;

    // void toggleUserSelection(int index)async{

    // }

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
    searchedUsers.assignAll(data);
  }

  

  @override
  void onClose() {
    groupNameController.dispose();
    super.onClose();
  }
}
