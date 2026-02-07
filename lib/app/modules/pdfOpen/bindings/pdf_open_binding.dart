import 'package:get/get.dart';

import '../controllers/pdf_open_controller.dart';

class PdfOpenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfOpenController>(
      () => PdfOpenController(),
    );
  }
}
