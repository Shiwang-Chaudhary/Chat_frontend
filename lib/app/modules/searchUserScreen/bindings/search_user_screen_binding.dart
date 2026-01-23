import 'package:get/get.dart';

import '../controllers/search_user_screen_controller.dart';

class SearchUserScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchUserScreenController>(
      () => SearchUserScreenController(),
    );
  }
}
