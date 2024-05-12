
import 'package:elden_kirala/pages/add/product/add_product.dart';
import 'package:elden_kirala/pages/auth/login/login.dart';
import 'package:elden_kirala/pages/auth/signup/signup.dart';
import 'package:elden_kirala/pages/details/details.dart';
import 'package:elden_kirala/pages/favorites/favorites.dart';
import 'package:elden_kirala/pages/highlights/highlights.dart';
import 'package:elden_kirala/pages/notFounded/not_founded.dart';
import 'package:elden_kirala/pages/profile/change-password/change-password.dart';
import 'package:elden_kirala/pages/profile/product_comment/product_comment.dart';
import 'package:elden_kirala/pages/profile/profile.dart';

import 'package:get/get.dart';
import '../controller/auth-controller/auth-controller.dart';

import '../main.dart';
import '../pages/profile/account-settings/account-settings.dart';
import '../pages/profile/addresess/addresess.dart';
import '../pages/profile/all-rent/all-rent.dart';
import '../pages/profile/notification/notification.dart';
import '../pages/profile/security/security.dart';

class RouteManager {
  static final AuthController _authController = Get.find(); // authController

  static final List<GetPage> routes = [
    GetPage(name: '/', page: () =>const MyAppMain()),
    GetPage(name: '/detail/:id', page: () => const Details()),
    GetPage(name: '/favorites', page: () => const Favorites()),
    GetPage(name: '/highlights', page: () => Highlights()),
    GetPage(name: '/account', page: () => const AccountSettings()),
    GetPage(name: '/change-password', page: () => const ChangePassword()),
    GetPage(name: '/profile', page: () => const Profile()),
    GetPage(name: '/notification', page: () => const Notification()),
    GetPage(name: '/security', page: () => const Security()),
    GetPage(name: '/addresess', page: () => const Addresess()),
    GetPage(name: '/all-rent', page: () => const AllRent()),
    GetPage(name: '/product-comment', page: () => const ProductComment()),

    GetPage(name: '/add-product', page: () => const AddProduct()),
    GetPage(name: '/add-comment', page: () => const AddProduct()),
    GetPage(name: '/add-rental', page: () => const AddProduct()),

    GetPage(name: '/login',  page: () => const LoginPage()),
    GetPage(name: '/signup', page: () => const SignupPage()),



    GetPage(name: '/not-founded', page: () => const NotFounded()),
    // Diğer rotaları buraya ekleyin
  ];
}
// const MyAppMain()