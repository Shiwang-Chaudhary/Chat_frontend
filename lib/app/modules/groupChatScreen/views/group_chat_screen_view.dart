import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTextfield.dart';
import 'package:chat_backend/app/widgets/customTile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../controllers/group_chat_screen_controller.dart';

class GroupChatScreenView extends GetView<GroupChatScreenController> {
  const GroupChatScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Chats",
          size: 23,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF24243E),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF24243E),
      body: Column(
        children: [
          // ElevatedButton(onPressed: (){
          //   controller.getGroupChats();
          // }, child: CustomText(text: "TEST BUTTON")),
          CustomTextfield(
            controller: TextEditingController(),
            prefixIcon: Icons.search,
            showSuffixIcon: false,
            hintText: "Search group chats",
            readOnly: true,
            onTap: () => Get.toNamed(Routes.SEARCH_GROUP_SCREEN),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() => 
          Expanded(
              child: ListView.builder(
                  itemCount: controller.groups.length,
                  itemBuilder: (context, index) {
                    final logger = Logger();
                     final group = controller.groups[index];
                     final groupName = group["name"];
                    logger.i("GROUP NAME: $groupName");
                     final adminName = group["admin"]["name"];
                    logger.i("ADMIN NAME: $adminName");
                    return CustomTile(
                        icon: Icons.chat,
                        text: groupName,
                        ontap: () {});
                  })))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.openCreateGroupScreen();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.group_add,color: Colors.white,),
      ),
    );
  }
}
