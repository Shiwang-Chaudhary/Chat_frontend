import 'package:get/get.dart';

import '../controllers/grp_infotab_controller.dart';

class GrpInfotabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrpInfotabController>(
      () => GrpInfotabController(),
    );
  }
}
