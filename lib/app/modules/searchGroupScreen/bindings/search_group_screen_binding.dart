import 'package:get/get.dart';

import '../controllers/search_group_screen_controller.dart';

class SearchGroupScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchGroupScreenController>(
      () => SearchGroupScreenController(),
    );
  }
}
