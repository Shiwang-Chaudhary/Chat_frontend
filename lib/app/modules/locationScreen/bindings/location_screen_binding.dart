import 'package:get/get.dart';

import '../controllers/location_screen_controller.dart';

class LocationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationScreenController>(
      () => LocationScreenController(),
    );
  }
}
