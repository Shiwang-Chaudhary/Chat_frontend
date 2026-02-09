import 'package:chat_backend/app/modules/grpMessageScreen/controllers/grp_message_screen_controller.dart';
import 'package:chat_backend/app/modules/grpMessageScreen/views/grp_message_screen_view.dart';
import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTextfield.dart';
import 'package:chat_backend/app/widgets/customTile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/group_chat_screen_controller.dart';

class GroupChatScreenView extends GetView<GroupChatScreenController> {
  const GroupChatScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Chats", size: 23, color: Colors.white),
        backgroundColor: Color.fromRGBO(43, 43, 73, 1),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF24243E),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          SizedBox(height: 10),
          Obx(() {
            if (controller.isLoading.value) {
              return Column(
                children: [
                  SizedBox(height: 200),
                  CircularProgressIndicator(color: Colors.blue),
                ],
              );
            }
            if (controller.groups.isEmpty) {
              return Center(
                child: CustomText(text: "No chats. \n Start chatting now"),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: controller.groups.length,
                itemBuilder: (context, index) {
                  // final logger = Logger();
                  final group = controller.groups[index];
                  // logger.i("GROUP : $group");
                  final groupName = group["name"];
                  // logger.i("GROUP NAME: $groupName");
                  final admin = group["admin"];
                  // logger.i("ADMIN NAME: $adminName");
                  final chatId = group["_id"];
                  final members = group["members"];
                  return CustomTile(
                    icon: Icons.chat,
                    text: groupName,
                    ontap: () {
                      Get.to(
                        () => GrpMessageScreenView(),
                        binding: BindingsBuilder(() {
                          Get.put(GrpMessageScreenController());
                        }),
                        arguments: {
                          "groupName": groupName,
                          "chatId": chatId,
                          "members": members,
                          "admin": admin,
                        },
                      );
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.openCreateGroupScreen();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.group_add, color: Colors.white),
      ),
    );
  }
}
