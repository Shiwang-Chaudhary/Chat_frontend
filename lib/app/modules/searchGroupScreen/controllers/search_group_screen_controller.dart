import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SearchGroupScreenController extends GetxController {
  final TextEditingController searchGrpController = TextEditingController();
  final logger = Logger();
  RxList<Map<String,dynamic>> groups = <Map<String,dynamic>>[].obs;

  void searchGroups(String text)async{
    final token = await StorageService.getData("token");
    final query = text.trim();
    if (query.isEmpty) {
      groups.clear();
      return;
    }
    final body = await ApiService.get("${ApiEndpoints.searchGroups}?query=$query", token);
    logger.i("SearchGroups DATA:$body");
    final List<Map<String,dynamic>> data = List<Map<String, dynamic>>.from(body["data"]);
    groups.clear();
    groups.assignAll(data);
    logger.i("GROUPS LIST: $groups");
  }
}
