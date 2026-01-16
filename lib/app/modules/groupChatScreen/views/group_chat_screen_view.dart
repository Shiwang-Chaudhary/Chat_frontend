import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTextfield.dart';
import 'package:chat_backend/app/widgets/customTile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/group_chat_screen_controller.dart';

class GroupChatScreenView extends GetView<GroupChatScreenController> {
  const GroupChatScreenView({Key? key}) : super(key: key);
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
            CustomTextfield(
                controller: controller.searchGrpController,
                prefixIcon: Icons.search,
                showSuffixIcon: false,
                hintText: "Search group chats"),
                SizedBox(height: 10,),
            Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return CustomTile(
                          icon: Icons.chat,
                          text: "Group ${index + 1}",
                          ontap: () {});
                    }))
          ],
        ));
  }
}
