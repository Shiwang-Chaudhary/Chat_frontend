import 'package:chat_backend/app/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxString name = "".obs;
  RxString email = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  Future getProfile() async {
    name.value = await StorageService.getData("name") ?? "User Name";
    email.value = await StorageService.getData("email") ?? "User Email";
  }
}
