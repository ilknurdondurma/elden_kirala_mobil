import 'package:elden_kirala/constanst/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constanst/fontSize.dart';
import '../../constanst/texts.dart';
import '../../constanst/colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        child: AppBar(
          forceMaterialTransparency: true,
          title: const Row(
            children: [
              Padding(
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
                        fontSize: MyFontSizes.fontSize,
                      ),
                    ),
                  ),
                  Text(
                    MyTexts.appBarUserTitle,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: MyFontSizes.fontSize*1.3,
                    ),
                  )
                ],
                             ),
            ],
          ),
          backgroundColor: MyColors.background,
          /*leading:IconButton(
            icon: Image.asset('assets/logo.png',width: 25, height: 25,),
            onPressed: () {
              Get.toNamed("/");
            },
          ),*/
          actions: <Widget>[
            IconButton(
              icon: const Icon(MyIcons.notificationIcon),
              onPressed: () {
                // Diğer işlevler burada gerçekleştirilebilir.
              },
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: IconButton(
                icon: Image.asset('assets/logo.png',width: 25, height: 25),
                onPressed: () {
                  Get.toNamed("/");
                },
              ),
            ),


          ],

        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}

class CustomAppBarInPage extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppBarInPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("${title}"),
      centerTitle: true,
      backgroundColor: MyColors.background,
      leading:IconButton(
        icon: Icon(MyIcons.backIcon),
        onPressed: () {
          Get.back();
        },
      ),
      actions: <Widget>[
        PopupMenuButton(
          position: PopupMenuPosition.under,
          color: Colors.white,
          useRootNavigator: true,
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              const PopupMenuItem(
                value: 'account',
                child: Text('Hesabım'),
              ),
              const PopupMenuItem(
                value: 'notification',
                child: Text('Bildirim Tercihlerim'),
              ),
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
            ];
          },
          onSelected: (value) {
            Get.toNamed('/${value}');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}