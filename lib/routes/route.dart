import 'package:elden_kirala/pages/add/product/add_product.dart';
import 'package:elden_kirala/pages/auth/login/login.dart';
import 'package:elden_kirala/pages/auth/signup/signup.dart';
import 'package:elden_kirala/pages/details/details.dart';
import 'package:elden_kirala/pages/favorites/favorites.dart';
import 'package:elden_kirala/pages/highlights/highlights.dart';
import 'package:elden_kirala/pages/notFounded/not_founded.dart';
import 'package:elden_kirala/pages/settings/addresess/addresess.dart';
import 'package:elden_kirala/pages/settings/all-rent/all-rent.dart';
import 'package:elden_kirala/pages/settings/notification/notification.dart';
import 'package:elden_kirala/pages/settings/security/security.dart';
import 'package:get/get.dart';
import '../controller/auth-controller/auth-controller.dart';
import '../main.dart';
import '../pages/settings/account/account.dart';

class RouteManager {
  static final AuthController _authController = Get.find(); // authController

  static final List<GetPage> routes = [
    GetPage(name: '/', page: () =>MyAppMain()),
    GetPage(name: '/detail/:id', page: () => Details()),
    GetPage(name: '/favorites', page: () => Favorites()),
    GetPage(name: '/highlights', page: () => Highlights()),
    GetPage(name: '/account', page: () => Account()),
    GetPage(name: '/notification', page: () => Notification()),
    GetPage(name: '/security', page: () => Security()),
    GetPage(name: '/addresess', page: () => Addresess()),
    GetPage(name: '/all-rent', page: () => AllRent()),

    GetPage(name: '/add-product', page: () => AddProduct()),
    GetPage(name: '/add-comment', page: () => AddProduct()),
    GetPage(name: '/add-rental', page: () => AddProduct()),

    GetPage(name: '/login',  page: () => LoginPage()),
    GetPage(name: '/signup', page: () => SignupPage()),



    GetPage(name: '/not-founded', page: () => NotFounded()),
    // Diğer rotaları buraya ekleyin
  ];
}
// const MyAppMain()