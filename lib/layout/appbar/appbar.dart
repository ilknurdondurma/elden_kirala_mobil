import 'package:elden_kirala/constanst/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constanst/fontSize.dart';
import '../../constanst/texts.dart';
import '../../constanst/colors.dart';
import '../../controller/auth-controller/auth-controller.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget  {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
          ),
           Column(
            children: [
              Opacity(
                opacity: 0.6,
                child: Text(
                  MyTexts.appBarTitle,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: MyFontSizes.fontSize_1(context),
                  ),
                ),
              ),
              Text(
                MyTexts.appBarUserTitle,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: MyFontSizes.fontSize_1(context),
                ),
              )
            ],
                         ),
        ],
      ),
      backgroundColor: MyColors.background,
      actions: <Widget>[
        IconButton(
          icon: const Icon(MyIcons.notificationIcon),
          onPressed: () {
            // Diğer işlevler burada gerçekleştirilebilir.
          },
        ),
        /*Container(
          margin: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Image.asset('assets/logo.png',width: 25, height: 25),
            onPressed: () {
              Get.toNamed("/");
            },
          ),
        ),*/
         PopupMenu(),


      ],

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


}

class CustomAppBarInPage extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  const CustomAppBarInPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("$title"),
      centerTitle: true,
      backgroundColor: MyColors.background,
      leading:IconButton(
        icon: const Icon(MyIcons.backIcon),
        onPressed: () {
          Get.back();
        },
      ),
      actions:  <Widget>[
        PopupMenu(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}

class CustomAppBarLogout extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  const CustomAppBarLogout({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("$title"),
      centerTitle: true,
      backgroundColor: MyColors.secondary,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class PopupMenu extends StatelessWidget {
  PopupMenu({super.key,});

  final AuthController _authController = Get.find(); // authController

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      color: Colors.white,
      useRootNavigator: true,
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          const PopupMenuItem(
            value: 'security',
            child: Text('Güvenlik'),
          ),
          const PopupMenuItem(
            value: 'addresses',
            child: Text('Adreslerim'),
          ),
          const PopupMenuItem(
            value: 'all-rent',
            child: Text('Tüm Kiralamalar'),
          ),
           PopupMenuItem(
            child: _authController.isAuthenticated.value?const Text('Çıkış Yap'):const Text('Giriş Yap'),
            onTap: ()=>_authController.isAuthenticated.value?_authController.logout():_authController.login(),
          ),
        ];
      },
      onSelected: (value) {
        Get.toNamed('/$value');
      },
    );
  }
}