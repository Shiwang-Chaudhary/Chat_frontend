import 'dart:developer';
import 'package:chat_backend/app/modules/Home/controller/home_controller.dart';
import 'package:chat_backend/app/modules/chatScreen/controllers/chat_screen_controller.dart';
import 'package:chat_backend/app/modules/chatScreen/views/chat_screen_view.dart';
import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTextfield.dart';
import 'package:chat_backend/app/widgets/customTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Chats", size: 23, color: Colors.white),
        backgroundColor: const Color(0xFF24243E),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF24243E),
      body: Column(
        children: [
          // ElevatedButton(
          //   onPressed: () async {
          //     controller.getLoggedUserId();
          //     controller.getChats();
          //   },
          //   child: CustomText(text: "TEST BUTTON"),
          // ),
          CustomTextfield(
            controller: controller.searchController,
            prefixIcon: Icons.search,
            showSuffixIcon: false,
            hintText: "Search personal chats",
          ),
          SizedBox(height: 10),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  final chat = controller.chats[index];
                  final chatId = chat["_id"];
                  final List members = chat["members"];
                  // log("CHAT ID in BUILDER:$chatId");
                  final otherUser = members.firstWhere(
                    (user) => user["_id"] != controller.loggedUserId,
                  );
                  final String otherUserName = otherUser["name"];
                  log("OTHER USER :${otherUser}");
                  // log("OTHER USER name :${otherUser["name"]}");
                  // log("OTHER USER ID:${otherUser["_id"]}");
                  return CustomTile(
                    icon: Icons.chat,
                    text: CapitalizeService.capitalizeEachWord(otherUserName),
                    ontap: () {
                      log("Tapped on Chat $otherUserName");
                      Get.to(
                        () => ChatScreenView(),
                        binding: BindingsBuilder(() {
                          Get.put(ChatScreenController());
                        }),
                        arguments: {"otherUser": otherUser, "chatId": chatId},
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
