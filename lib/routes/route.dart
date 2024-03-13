import 'package:elden_kirala/pages/details/details.dart';
import 'package:elden_kirala/pages/favorites/favorites.dart';
import 'package:elden_kirala/pages/notFounded/not_founded.dart';
import 'package:elden_kirala/pages/settings/addresess/addresess.dart';
import 'package:elden_kirala/pages/settings/all-rent/all-rent.dart';
import 'package:elden_kirala/pages/settings/notification/notification.dart';
import 'package:elden_kirala/pages/settings/security/security.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../main.dart';
import '../pages/settings/account/account.dart';

class RouteManager {
  static final List<GetPage> routes = [
    GetPage(name: '/', page: () => const MyAppMain()), // MyAppMain sayfasını / rota olarak kullanıyoruz
    GetPage(name: '/detail', page: () => Details()),
    GetPage(name: '/favorites', page: () => Favorites()),
    GetPage(name: '/account', page: () => Account()),
    GetPage(name: '/notification', page: () => Notification()),
    GetPage(name: '/security', page: () => Security()),
    GetPage(name: '/addresess', page: () => Addresess()),
    GetPage(name: '/all-rent', page: () => AllRent()),


    GetPage(name: '/not-founded', page: () => NotFounded()),
    // Diğer rotaları buraya ekleyin
  ];
}