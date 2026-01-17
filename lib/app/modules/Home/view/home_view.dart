import 'package:chat_backend/app/modules/Home/controller/home_controller.dart';
import 'package:chat_backend/app/routes/app_routes.dart';
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
            ElevatedButton(onPressed: ()async{
               controller.getLoggedUserId();
               controller.getChats();
            }, child: CustomText(text: "TEST BUTTON")),
            CustomTextfield(
                controller: controller.searchController,
                prefixIcon: Icons.search,
                showSuffixIcon: false,
                hintText: "Search personal chats"),
                SizedBox(height: 10,),
            Expanded(
                child: ListView.builder(
                    itemCount: controller.chats.length,
                    itemBuilder: (context, index) {
                      final chat = controller.chats[index];
                      final List members = chat["members"];
                      final otherUser = members.firstWhere((user) => user["_id"]!=controller.loggedUserId);
                      final String otherUserName = otherUser["name"];
                      print("OTHER USER :${otherUser}");
                      print("OTHER USER name :${otherUser["name"]}");
                      print("OTHER USER ID:${otherUser["_id"]}");
                      return CustomTile(
                          icon: Icons.chat,
                          text: controller.capitalizeEachWord(otherUserName),
                          ontap: () {
                            print("Tapped on Chat ${otherUserName}");
                            Get.toNamed(Routes.CHAT_SCREEN);
                          });
                    }))
          ],
        ));
  }
}
