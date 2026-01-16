import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var name = "".obs;
   var email = "".obs;
   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }
  Future getProfile()async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   name.value = prefs.getString("name")??"example name";
   email.value = prefs.getString("email")??"examplename@gmail.com";
  }
}
