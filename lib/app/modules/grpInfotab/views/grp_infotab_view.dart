import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:chat_backend/app/widgets/customTile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/grp_infotab_controller.dart';

class GrpInfotabView extends GetView<GrpInfotabController> {
  const GrpInfotabView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Group info", size: 20),
        // centerTitle: true,
        backgroundColor: const Color(0xFF24243E),
      ),
      backgroundColor: const Color(0xFF24243E),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(backgroundColor: Colors.blue, radius: 60),
          SizedBox(height: 10),
          CustomText(
            text: CapitalizeService.capitalizeEachWord(controller.groupName),
            size: 25,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: "Group: ", size: 20, color: Colors.grey),
              Obx(
                () => CustomText(
                  text: "${controller.members.length} members",
                  size: 20,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          CustomTile(
            icon: Icons.person_add,
            text: "Add members",
            ontap: () {
              controller.openAddMemberScreen();
            },
            iconColor: Colors.greenAccent,
          ),
          // SizedBox(height: 10),
          Align(
            alignment: AlignmentGeometry.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomText(
                text: "Members",
                size: 20,
                color: const Color.fromARGB(255, 206, 206, 206),
              ),
            ),
          ),
          Obx(
            () => Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                itemCount: controller.members.length,
                itemBuilder: (context, index) {
                  final member = controller.members[index];
                  final memberName = member["name"];
                  final memberEmail = member["email"];
                  final memberId = member["_id"];
                  final adminId = controller.admin["_id"];
                  final isAdmin = memberId == adminId;
                  return GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      tileColor: const Color(0xFF24243E),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      leading: CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.yellow,
                        child: Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                      title: CustomText(
                        text: CapitalizeService.capitalizeEachWord(memberName),
                        color: Colors.white,
                        size: 20,
                        weight: FontWeight.w400,
                      ),
                      subtitle: CustomText(
                        text: memberEmail,
                        color: Colors.white,
                        weight: FontWeight.w400,
                      ),
                      trailing: isAdmin
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.blue,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: CustomText(
                                  text: "Group admin",
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  );
                },
              ),
            ),
          ),
          CustomTile(
            icon: Icons.logout,
            color: Colors.red,
            text: "Exit group",
            textColor: Colors.red,
            ontap: () {},
            iconColor: const Color(0xFF24243E),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
