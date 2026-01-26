import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTextfield.dart';
import 'package:chat_backend/app/widgets/customTile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_user_screen_controller.dart';

class SearchUserScreenView extends GetView<SearchUserScreenController> {
  const SearchUserScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF24243E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              TextField(
                onChanged: (value) => controller.seachUsers(value),
                style:
                    const TextStyle(color: Colors.white), // 👈 typed text color
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Search personal chats",
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6)), // 👈 hint color
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: Colors.black, width: 1), // 👈 normal
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400, // 👈 tapped
                      width: 1,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  child: controller.users.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: "Please search the user name",
                            size: 18,
                            color: Colors.white54,
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.users.length,
                          itemBuilder: (context, index) {
                            final user = controller.users[index];
                            final String name = user["name"] ?? "NAME";
                            final userId = user["_id"];

                            return CustomTile(
                                showSubtitle: false,
                                icon: Icons.message,
                                text: CapitalizeService.capitalizeEachWord(name),
                                //trailing: Icons.message,
                                ontap: () {
                                  controller.createOrGetChatRoom(userId,name);
                                });
                          },
                        ),
                ),
              )
            ],
          ),
        ));
  }
}
