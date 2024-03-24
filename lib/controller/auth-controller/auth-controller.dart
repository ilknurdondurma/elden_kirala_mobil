import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final  box = GetStorage();

  var isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    isAuthenticated.value = box.read('user') != null;
  }

  void login() {
    isAuthenticated.value = true;
  }

  void logout() {
    isAuthenticated.value = false;
    box.remove('user');
  }
}
