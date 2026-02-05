import 'package:get/get.dart';

class ImageOpenScreenController extends GetxController {
  late String fileUrl;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fileUrl = Get.arguments["fileUrl"];
  }
}
