import 'package:get_storage/get_storage.dart';

class MyTexts {
  static final box = GetStorage();

  static String get userName {
    final username = box.read("user")['name'] ?? '';
    //final usersurname = box.read("user")['surname'] ?? '';
    return '$username';
  }
  static String get userSurname {
    //final username = box.read("user")['name'] ?? '';
    final usersurname = box.read("user")['surname'] ?? '';
    return '$usersurname';
  }
  static String get fullName {
    final username = box.read("user")['name'] ?? '';
    final usersurname = box.read("user")['surname'] ?? '';
    return '$username $usersurname';
  }

  static String get email {
    final usermail = box.read("user")['email'] ?? '';
    return '$usermail';
  }

  static String get city {
    final userCity = box.read("user")['city'] ?? '';
    final userDistrict = box.read("user")['district'] ?? '';
    return '$userDistrict $userCity';
  }
  static String get address {
    final userCity = box.read("user")['fullAddress'] ?? '';
    return '$userCity';
  }


  static const String appBarTitle = "Welcome";
  static const String categories = "Tüm Kategoriler";
  static const String search = "Aramak istediğiniz şeyi girin..";
  static const String home = "AnaSayfa";
  static const String account = "Hesabım";
  static const String notification = "Bildirim Tercihlerim";
  static const String security = "Güvenlik";
  static const String addresses = "Adreslerim";
  static const String allRent = "Tüm Kiralamalar";
  static const String details = "Details";
  static const String favorites = "Favorilerim";
  static const String highlights = "Vitrin";
  static const String messages = "Mesajlarım";
  static const String addProduct = "İlan Yayınla";
  static const String name = "Eldenkirala.com";
}
