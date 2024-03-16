import 'package:get/get.dart';

class AuthController extends GetxController {
  var isAuthenticated = true.obs; // Obx ile değişiklikleri dinleyeceğiz

  void login() {
    // Giriş yapıldığında
    isAuthenticated.value = true; // Auth durumunu güncelle
  }

  void logout() {
    // Çıkış yapıldığında
    isAuthenticated.value = false; // Auth durumunu güncelle
  }
}
