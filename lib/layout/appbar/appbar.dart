import 'package:elden_kirala/constanst/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constanst/fontSize.dart';
import '../../constanst/texts.dart';
import '../../constanst/colors.dart';
import '../../controller/auth-controller/auth-controller.dart';
GetStorage box = GetStorage();


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
                MyTexts.fullName,
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
         //PopupMenu(),


      ],

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


}

class CustomAppBarInPage extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  final bool? showLeadingIcon;
  const CustomAppBarInPage({super.key, required this.title, this.showLeadingIcon=true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '$title',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: MyFontSizes.fontSize_1(context),
          fontWeight: FontWeight.w500
        ),
      ),
      centerTitle: true,
      backgroundColor: MyColors.tertiary.withOpacity(0.1),
      leading: showLeadingIcon! ? IconButton(
        icon: const Icon(MyIcons.backIcon, size: 20,),
        onPressed: () {
          Get.back();
        },
      ) : null,
      actions:  <Widget>[
        //PopupMenu(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
            onTap: () async =>_authController.isAuthenticated.value
                ? {
                      _authController.logout() ,
                      await box.remove('user'),
                      Get.offAllNamed("/login"),
                  }
                : {
                      _authController.login(),
                    }),
        ];
      },
      onSelected: (value) {
        Get.toNamed('/$value');
      },
    );
  }
}