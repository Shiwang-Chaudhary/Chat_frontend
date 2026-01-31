import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GroupChatScreenController extends GetxController {
  final TextEditingController searchGrpController = TextEditingController();
  final logger = Logger();
  // late RxList members;
  var groups = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getGroupChats();
  }
  void openCreateGroupScreen()async{
    final result = await Get.toNamed(Routes.CREATE_GROUP_SCREEN);
    if (result!=null) {
      getGroupChats();
    }
  }
  void getGroupChats()async{
    final token = await StorageService.getData("token");
    final response = await ApiService.get(ApiEndpoints.getGroupChats, token);
    logger.i("Get Group Chat: $response");
    final groupData = response["data"];
    // members = response["members"];
    groups.assignAll(groupData);
  }
}
