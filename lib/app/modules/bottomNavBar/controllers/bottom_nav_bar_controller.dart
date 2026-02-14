import 'package:chat_backend/app/modules/Home/view/home_view.dart';
import 'package:chat_backend/app/modules/groupChatScreen/views/group_chat_screen_view.dart';
import 'package:chat_backend/app/modules/locationScreen/views/location_screen_view.dart';
import 'package:chat_backend/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;
  final pages = [
    HomeView(),
    GroupChatScreenView(),
    ProfileView(),
    LocationScreenView(),
  ];
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
