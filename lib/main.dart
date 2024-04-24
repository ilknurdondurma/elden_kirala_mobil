
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:elden_kirala/constanst/colors.dart';
import 'package:elden_kirala/constanst/fontFamily.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:elden_kirala/pages/add/product/add_product.dart';
import 'package:elden_kirala/pages/favorites/favorites.dart';
import 'package:elden_kirala/pages/home/home.dart';
import 'package:elden_kirala/pages/message/message.dart';
import 'package:elden_kirala/pages/settings/account/account.dart';
import 'package:flutter/material.dart';
import 'package:elden_kirala/routes/route.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'constanst/icons.dart';
import 'controller/auth-controller/auth-controller.dart';
import 'layout/appbar/appbar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Eklenmesi gereken bir satır
  await GetStorage.init();
  await Get.put(AuthController(),permanent: true);
  final box = GetStorage();
  final initialRoute = box.read('user') != null ? '/' : '/login';

  runApp(MyApp(initialRoute: initialRoute));}


void add(){}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({super.key, required this.initialRoute});
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: RouteManager.routes,
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      debugShowMaterialGrid: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: MyFontFamilies.fontFamily,
        appBarTheme: const AppBarTheme(),
      ),
    );
  }
}


class MyAppMain extends StatefulWidget {
  const MyAppMain({super.key});

  @override
  State<MyAppMain> createState() => _MyAppMainState();
}

class _MyAppMainState extends State<MyAppMain> {
  int _currentIndex = 0;
  final List _screens = [const Home(),const Message(),const Favorites(),const Account()];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColors.background,
      appBar: _currentIndex != 3 ? CustomAppBar() :null ,
      extendBodyBehindAppBar: false,
      body: _screens[_currentIndex],
      floatingActionButton: _currentIndex != 3
        ? FloatingActionButton(
          onPressed: ()=>Get.toNamed('/add-product'),
          backgroundColor: MyColors.secondary,
          child: const IconButton(
            icon: Icon(MyIcons.addIcon,color: Colors.white,),
            onPressed: null,
          ),)
      : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomNavigationBar: buildBottomNavyBar(context),


    );
  }

  BottomNavyBar buildBottomNavyBar(BuildContext context) {
    return BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        containerHeight:MediaQuery.of(context).size.height*0.07,

        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(MyIcons.home),
            title: const Text(MyTexts.home),
            activeColor: MyColors.secondary,
            inactiveColor: MyColors.tertiary,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(MyIcons.messageIcon),
            title: const Text(MyTexts.messages),
            activeColor: MyColors.secondary,
            inactiveColor: MyColors.tertiary,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(MyIcons.favoriteIcon),
            title: const Text(MyTexts.favorites),
            activeColor: MyColors.secondary,
            inactiveColor: MyColors.tertiary,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(MyIcons.accountIcon),
            title: const Text(MyTexts.account),
            activeColor: MyColors.secondary,
            inactiveColor: MyColors.tertiary,
            textAlign: TextAlign.center,
          ),
        ],
      );
  }
}




