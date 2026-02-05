import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/create_group_screen_controller.dart';

class CreateGroupScreenView extends GetView<CreateGroupScreenController> {
  const CreateGroupScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Create Group", color: Colors.white, size: 26),
        centerTitle: true,
        backgroundColor: const Color(0xFF24243E),
      ),
      backgroundColor: const Color(0xFF24243E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Column(
          children: [
            // 🟢 Group Info Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // CircleAvatar(
                  //   radius: 28,
                  //   child: IconButton(
                  //     icon: const Icon(Icons.camera_alt),
                  //     onPressed: () {
                  //       // TODO: pick image
                  //     },
                  //   ),
                  // ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: controller.groupNameController,
                      decoration: const InputDecoration(
                        hintText: "Group name",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 👥 Members Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Add members",
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            //SEARCH TEXTFIELD
            TextField(
              onChanged: (value) => controller.seachUsers(value),
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Search users",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Colors.blue.shade400, // 👈 tapped
                    width: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // 👥 Members List
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.searchedUsers.length,
                  itemBuilder: (context, index) {
                    final user = controller.searchedUsers[index];
                    final String userName = user["name"];
                    final String userId = user["_id"];
                    controller.logger.i(
                      "isSelected:${controller.selectedMembersId.contains(userId)}",
                    );
                    return Obx(
                      () => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: CustomText(
                            text: CapitalizeService.capitalizeEachWord(
                              userName[0],
                            ),
                          ),
                        ),
                        title: CustomText(
                          text: CapitalizeService.capitalizeEachWord(userName),
                          color: Colors.white,
                          size: 20,
                        ),
                        trailing: Checkbox(
                          activeColor: Colors.blue,
                          value: controller.selectedMembersId.contains(userId),
                          onChanged: (_) =>
                              controller.toggleUserSelection(userId),
                        ),
                        onTap: () => controller.toggleUserSelection(userId),
                      ),
                    );
                  },
                ),
              ),
            ),

            // 🔵 Create Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    controller.createGroup();
                  },
                  child: const CustomText(
                    text: "Create Group",
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
