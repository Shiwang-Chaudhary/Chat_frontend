import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_group_screen_controller.dart';

class SearchGroupScreenView extends GetView<SearchGroupScreenController> {
  const SearchGroupScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24243E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SafeArea(
          child: Column(
            children: [
              // ElevatedButton(onPressed: (){
              //    controller.searchGrpController
              // }, child: Text("TEST BUTTON")),
              SizedBox(
                height: 50,
              ),
              TextField(
                onChanged: (value) => controller.searchGroups(value),
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Search personal chats",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 1), // 👈 normal
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
              SizedBox(
                height: 20,
              ),
              Obx(
                () => Expanded(
                  child: controller.groups.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: "Please search the group name",
                            size: 18,
                            color: Colors.white54,
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.groups.length,
                          itemBuilder: (context, index) {
                            final group = controller.groups[index];
                            final String name = group["name"] ?? "NAME";
                            final userId = group["_id"];

                            return CustomTile(
                                showSubtitle: false,
                                icon: Icons.message,
                                text:
                                    CapitalizeService.capitalizeEachWord(name),
                                //trailing: Icons.message,
                                ontap: () {
                                  Get.offAndToNamed(Routes.GROUP_CHAT_SCREEN);
                                });
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
