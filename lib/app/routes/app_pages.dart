import 'package:get/get.dart';

import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/view/home_view.dart';
import '../modules/ImageOpenScreen/bindings/image_open_screen_binding.dart';
import '../modules/ImageOpenScreen/views/image_open_screen_view.dart';
import '../modules/OTP_screen/bindings/o_t_p_screen_binding.dart';
import '../modules/OTP_screen/views/o_t_p_screen_view.dart';
import '../modules/VideoOpenScreen/bindings/video_open_screen_binding.dart';
import '../modules/VideoOpenScreen/views/video_open_screen_view.dart';
import '../modules/bottomNavBar/bindings/bottom_nav_bar_binding.dart';
import '../modules/bottomNavBar/views/bottom_nav_bar_view.dart';
import '../modules/chatScreen/views/chat_screen_view.dart';
import '../modules/createGroupScreen/bindings/create_group_screen_binding.dart';
import '../modules/createGroupScreen/views/create_group_screen_view.dart';
import '../modules/groupChatScreen/bindings/group_chat_screen_binding.dart';
import '../modules/groupChatScreen/views/group_chat_screen_view.dart';
import '../modules/grpMessageScreen/bindings/grp_message_screen_binding.dart';
import '../modules/grpMessageScreen/views/grp_message_screen_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/searchGroupScreen/bindings/search_group_screen_binding.dart';
import '../modules/searchGroupScreen/views/search_group_screen_view.dart';
import '../modules/searchUserScreen/bindings/search_user_screen_binding.dart';
import '../modules/searchUserScreen/views/search_user_screen_view.dart';
import '../modules/signUp/bindings/sign_up_binding.dart';
import '../modules/signUp/views/sign_up_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SIGN_UP;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.BOTTOM_NAV_BAR,
      page: () => const BottomNavBarView(),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: Routes.CHAT_SCREEN,
      page: () => const ChatScreenView(),
      //binding: ChatScreenBinding(),
    ),
    GetPage(
      name: Routes.GROUP_CHAT_SCREEN,
      page: () => const GroupChatScreenView(),
      binding: GroupChatScreenBinding(),
    ),
    GetPage(
      name: Routes.O_T_P_SCREEN,
      page: () => const OTPScreenView(),
      binding: OTPScreenBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_USER_SCREEN,
      page: () => const SearchUserScreenView(),
      binding: SearchUserScreenBinding(),
    ),
    GetPage(
      name: Routes.CREATE_GROUP_SCREEN,
      page: () => const CreateGroupScreenView(),
      binding: CreateGroupScreenBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_GROUP_SCREEN,
      page: () => const SearchGroupScreenView(),
      binding: SearchGroupScreenBinding(),
    ),
    GetPage(
      name: Routes.GRP_MESSAGE_SCREEN,
      page: () => const GrpMessageScreenView(),
      binding: GrpMessageScreenBinding(),
    ),
    GetPage(
      name: Routes.IMAGE_OPEN_SCREEN,
      page: () => const ImageOpenScreenView(),
      binding: ImageOpenScreenBinding(),
    ),
    GetPage(
      name: Routes.VIDEO_OPEN_SCREEN,
      page: () => const VideoOpenScreenView(),
      binding: VideoOpenScreenBinding(),
    ),
  ];
}
