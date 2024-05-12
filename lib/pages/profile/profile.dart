import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:elden_kirala/constanst/colors.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:flutter/material.dart';
import '../../../api/api.dart';
import '../../../constanst/fontSize.dart';
import '../../../constanst/texts.dart';
import '../../../layout/appbar/appbar.dart';
import '../../components/textField/custom_input_field.dart';
import '../../controller/auth-controller/auth-controller.dart';

final box = GetStorage();

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<Map<String, String>> buttonData = [
    {
      'id': "1",
      'variant': "PurpleOutline",
      'label': 'Şifre Değiştir',
      'route': '/change-password'
    },
    //{ 'id': 2, 'variant': "PurpleOutline", 'label': 'Tüm Kiralamalarım','route':'' },
    // { 'id': 3, 'variant': "PurpleOutline", 'label': 'Ürün & Satıcı Yorumlarım','route':'' },
    {
      'id': "4",
      'variant': "PurpleOutline",
      'label': 'Bildirim Tercihlerim',
      'route': '/notification'
    },
    {
      'id': "5",
      'variant': "PurpleOutline",
      'label': 'Adres Düzenle',
      'route': '/addresess'
    },
    {
      'id': "6",
      'variant': "PurpleOutline",
      'label': 'Güvenlik',
      'route': '/security'
    },
    {
      'id': "7",
      'variant': "PurpleOutline",
      'label': 'Hesap Ayarlarım',
      'route': '/account'
    },
    {
      'id': "8",
      'variant': "PurpleOutline",
      'label': 'Çıkış Yap',
      'route': '/login'
    },
  ];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController(text: MyTexts.userName);
  final TextEditingController _userSurnameController = TextEditingController(text: MyTexts.userSurname);
  final TextEditingController _emailController = TextEditingController(text: MyTexts.email);
  final AuthController _authController = Get.find();

  final int userId = box.read("user")['id'];
  final String userPassword = box.read("user")['password'];
  final String userCity = box.read("user")['city'];
  final String userDistrict = box.read("user")['district'];
  bool _isEditing = false;

  Future<void> handleSubmit() async {
    print(userPassword);
    try {
      Map<String, dynamic> updatedUser = {
        "email": _emailController.text,
        "name": _userNameController.text,
        "surname": _userSurnameController.text
      };
      dio.Response response = await Api.updateUser(userId, updatedUser);
      if (response.statusCode == 200) {
        print("İstek başarıyla gönderildi. Yanıt: ${response.data}");
        Map<String, dynamic> responseData = response.data['data'];
        await box.write('user', responseData);
        print(box.read('user'));
        Get.reload();
      }
    } catch (e) {
      print("İstek sırasında bir hata oluştu: $e");
    }
  }

  void openSubMenu(BuildContext context, List<Map<String, String>> subMenu) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: subMenu.map((item) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['label']! + "mak İstediğine Emin Misin ?", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Column(
                      children: [
                        Center(
                            child: ElevatedButton(
                              onPressed: () async =>_authController.isAuthenticated.value
                                  ? {
                                _authController.logout() ,
                                await box.remove('user'),
                                Get.offAllNamed("/login"),
                              }
                                  : {
                                _authController.login(),
                              },
                              child: Text("Çıkış Yap"),)),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.tertiary.withOpacity(0.4),
        appBar: const CustomAppBarInPage(
          title: "My Profile",
          showLeadingIcon: false,
        ),
        body: SingleChildScrollView(
            child: SizedBox(
              //height: MyContainerSizes.heightSize(context, 1),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                            width: MyContainerSizes.widthSize(context, 0.9),
                            //height: MyContainerSizes.heightSize(context, 0.08),
                            child: CustomTextField(
                              controller: _searchController,
                              placeholder: MyTexts.search,
                              label: "Ara",
                              isBorder: true,
                              icon: const Icon(Icons.search,size: 15,),
                              width: 1,
                            )),
                      ),
                      Container(
                        width: MyContainerSizes.widthSize(context, 0.9),
                        height: _isEditing
                            ? MyContainerSizes.heightSize(context, 0.35)
                            : MyContainerSizes.heightSize(context, 0.25),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: MyColors.background,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/profile_image.jpg',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: MyColors.secondary,
                                          ),
                                          child: const Icon(
                                            Icons.cloud_download,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _isEditing
                                        ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: CustomTextField(
                                              controller: _userNameController,
                                              placeholder: "İlknur",
                                              label: "Ad"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: CustomTextField(
                                              controller:
                                              _userSurnameController,
                                              placeholder: "Dondurma",
                                              label: "Soyad"),
                                        ),
                                      ],
                                    )
                                        : Text(
                                      "${_userNameController.text}  ${_userSurnameController.text}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize:
                                        MyFontSizes.fontSize_1(context),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    _isEditing
                                        ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: CustomTextField(
                                            controller: _emailController,
                                            placeholder: "abc@gmail.com",
                                            label: "Email"))
                                        : Text(
                                      _emailController.text,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize:
                                        MyFontSizes.fontSize_1(context),
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black26,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isEditing = !_isEditing;
                                          if (!_isEditing) {
                                            handleSubmit();
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              _isEditing ? Icons.save : Icons.edit,
                                              size: _isEditing ? 25 : 15,
                                              //size: 15,
                                              color: MyColors.secondary,
                                            ),
                                            SizedBox(
                                              width: _isEditing ? 15 : 0,
                                            ),
                                            GestureDetector(
                                              child: Icon(
                                                _isEditing ? Icons.close : null,
                                                size: 25,
                                                color: MyColors.secondary,
                                              ),
                                              onTap: () => {
                                                setState(() {
                                                  _isEditing = false;
                                                })
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          width: MyContainerSizes.widthSize(context, 0.9),
                          //height: MyContainerSizes.heightSize(context, 0.9),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Stack(
                                                children: [
                                                  ElevatedButton(
                                                    child: Text("Tüm Kiralamalarım",
                                                        style: TextStyle(
                                                            fontSize: MyFontSizes
                                                                .fontSize_0(
                                                                context))),
                                                    onPressed: () {
                                                      Get.toNamed('/all-rent');
                                                    },
                                                    //size: 'xsmall',
                                                    //variant: button['variant'].toString(),
                                                  ),
                                                  const Positioned(
                                                      right: 5,
                                                      bottom: 15,
                                                      child: Icon(
                                                        Icons.chevron_right,
                                                        color: MyColors.secondary,
                                                        size: 20,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Stack(
                                                children: [
                                                  ElevatedButton(
                                                    child: Text(
                                                        "Ürün & Satıcı Yorumlarım",
                                                        style: TextStyle(
                                                            fontSize: MyFontSizes
                                                                .fontSize_0(
                                                                context))),
                                                    onPressed: () {
                                                      Get.toNamed('/product-comment');

                                                    },
                                                    //size: 'xsmall',
                                                    //variant: button['variant'].toString(),
                                                  ),
                                                  const Positioned(
                                                      right: 0,
                                                      bottom: 15,
                                                      child: Icon(
                                                        Icons.chevron_right,
                                                        color: MyColors.secondary,
                                                        size: 20,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10,
                                          mainAxisExtent: 40),
                                      itemCount: buttonData.length,
                                      itemBuilder: (context, index) {
                                        final button = buttonData[index];
                                        return Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ElevatedButton(
                                              child: Text(
                                                button['label'].toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                    MyFontSizes.fontSize_0(
                                                        context)),
                                              ),
                                              onPressed: () {
                                               Get.toNamed(button['route']!);
                                              },
                                              //size: 'xsmall',
                                              //variant: button['variant'].toString(),
                                            ),
                                            const Positioned(
                                                right: 10,
                                                bottom: 10,
                                                child: Icon(
                                                  Icons.chevron_right,
                                                  color: MyColors.secondary,
                                                  size: 20,
                                                ))
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MyContainerSizes.widthSize(context, 0.9),
                        height: MyContainerSizes.heightSize(context, 0.25),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: MyColors.background),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("Destek",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: MyFontSizes.fontSize_2(context),
                                      color: Colors.black45)),
                            ),
                            const Divider(
                              height: 20, // Çizginin yüksekliği (isteğe bağlı)
                              thickness: 0.5, // Çizginin kalınlığı (isteğe bağlı)
                              color: Colors.black, // Çizginin rengi (isteğe bağlı)
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star_rate_outlined,
                                          size: 20, color: MyColors.secondary),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Uygulamayı Değerlendir"),
                                    ],
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: MyColors.secondary,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 20, // Çizginin yüksekliği (isteğe bağlı)
                              thickness: 0.05, // Çizginin kalınlığı (isteğe bağlı)
                              color: Colors.black, // Çizginin rengi (isteğe bağlı)
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.help_outline_sharp,
                                        size: 20,
                                        color: MyColors.secondary,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Yardım & Sıkça Sorulan Sorular"),
                                    ],
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: MyColors.secondary,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 20, // Çizginin yüksekliği (isteğe bağlı)
                              thickness: 0.05, // Çizginin kalınlığı (isteğe bağlı)
                              color: Colors.black, // Çizginin rengi (isteğe bağlı)
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.support_agent,
                                          size: 20, color: MyColors.secondary),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Asistan"),
                                    ],
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: MyColors.secondary,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}




