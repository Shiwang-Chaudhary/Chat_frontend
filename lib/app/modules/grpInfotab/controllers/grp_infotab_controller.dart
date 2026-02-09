import 'package:chat_backend/app/modules/groupChatScreen/controllers/group_chat_screen_controller.dart';
import 'package:chat_backend/app/modules/grpMessageScreen/controllers/grp_message_screen_controller.dart';
import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/services/api_endpoints.dart';
import 'package:chat_backend/app/services/api_service.dart';
import 'package:chat_backend/app/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GrpInfotabController extends GetxController {
  late Map<String, dynamic> admin;
  RxList<Map<String, dynamic>> members = <Map<String, dynamic>>[].obs;
  late String groupName;
  late String chatId;
  final logger = Logger();
  @override
  void onInit() {
    logger.i("Oninit called");
    admin = Get.arguments["admin"];
    // members = Get.arguments["members"];
    groupName = Get.arguments["groupName"];
    chatId = Get.arguments["chatId"];
    logger.i("AdminInfo: $admin");
    logger.i("ChatId: $chatId");
    getMembers();
    super.onInit();
  }

  void getMembers() async {
    final token = await StorageService.getData("token");
    final response = await ApiService.get(ApiEndpoints.getGroupChats, token);
    logger.i("Get Group Chat: $response");
    final List chats = response["data"];
    final Map<String, dynamic> group = chats.firstWhere(
      (chat) => chat["_id"] == chatId,
    );
    logger.i("Group: $group");
    final List<Map<String, dynamic>> groupMembers =
        List<Map<String, dynamic>>.from(group["members"]);
    members.assignAll(groupMembers);
    logger.i("Members list before sorting: $members");
    final adminId = admin["_id"];

    members.sort((a, b) {
      if (a["_id"] == adminId) return -1;
      if (b["_id"] == adminId) return 1;
      return a["name"].toLowerCase().compareTo(b["name"].toLowerCase());
    });
    logger.i("Members list after sorting: $members");
  }

  void openAddMemberScreen() async {
    final result = await Get.toNamed(
      Routes.ADD_MEMBER_SCREEN,
      arguments: {
        "members": members,
        "admin": admin,
        // "groupName":groupName,
        "chatId": chatId,
      },
    );
    logger.i("result value in OpenAddMemberScreen:$result");
    if (result == true) {
      getMembers();
    }
  }
}
