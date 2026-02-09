import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_member_screen_controller.dart';

class AddMemberScreenView extends GetView<AddMemberScreenController> {
  const AddMemberScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddMemberScreenView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                  final admin = controller.admin["_id"];
                  // final member = controller.members[index];
                  final isAlreadyJoined = controller.members.any(
                    (member) => member["_id"] == userId,
                  );
                  controller.logger.i("isAlreadyJoined: $isAlreadyJoined");
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
                        color: isAlreadyJoined
                            ? Colors.grey.shade400
                            : Colors.white,
                        size: 20,
                      ),
                      subtitle: isAlreadyJoined
                          ? Text(
                              "Already in the group",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade400,
                              ),
                            )
                          : null,
                      trailing: isAlreadyJoined
                          ? SizedBox()
                          : Checkbox(
                              activeColor: Colors.blue,
                              value: controller.selectedMembersId.contains(
                                userId,
                              ),
                              onChanged: (_) =>
                                  controller.toggleUserSelection(userId),
                            ),
                      onTap: () => isAlreadyJoined
                          ? null
                          : controller.toggleUserSelection(userId),
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
                  controller.addMembers();
                },
                child: const CustomText(text: "Add member", color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
