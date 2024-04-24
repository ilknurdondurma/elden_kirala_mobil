import 'package:elden_kirala/constanst/colors.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../components/buttons/button.dart';
import '../../../constanst/fontSize.dart';
import '../../../constanst/texts.dart';
import '../../../layout/appbar/appbar.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _HesabimState();
}

class _HesabimState extends State<Account> {
  final buttonData = [
    { 'id': 1, 'variant': "PurpleOutline", 'label': 'Şifre Değiştir' ,'icon':'password' },
    //{ 'id': 2, 'variant': "PurpleOutline", 'label': 'Tüm Kiralamalarım','icon':'password' },
   // { 'id': 3, 'variant': "PurpleOutline", 'label': 'Ürün & Satıcı Yorumlarım','icon':'password' },
    { 'id': 4, 'variant': "PurpleOutline", 'label': 'Bildirim Tercihlerim','icon':'password' },
    { 'id': 5, 'variant': "PurpleOutline", 'label': 'Adres Düzenle','icon':'password' },
    { 'id': 6, 'variant': "PurpleOutline", 'label': 'Güvenlik','icon':'password' },
    { 'id': 7, 'variant': "PurpleOutline", 'label': 'Hesap Ayarlarım','icon':'password' },
    { 'id': 8, 'variant': "PurpleOutline", 'label': 'Çıkış Yap','icon':'logout' },
  ];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.tertiary.withOpacity(0.4),
      appBar: CustomAppBarInPage(title: "My Profile",showLeadingIcon: false,),
      body:SingleChildScrollView(
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
                    height: MyContainerSizes.heightSize(context, 0.045),
                    child: TextField(

                      controller: _searchController,
                      onChanged: null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        hintText: MyTexts.search,
                        hintStyle:TextStyle(fontSize: MyFontSizes.fontSize_0(context)),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MyContainerSizes.widthSize(context, 0.9),
                  height: MyContainerSizes.heightSize(context, 0.20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: MyColors.background
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: MyColors.secondary,),
                                    child: Icon(
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
                              Text(
                                MyTexts.fullName,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: MyFontSizes.fontSize_1(context),
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                MyTexts.email,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: MyFontSizes.fontSize_1(context),
                                    fontWeight: FontWeight.w500,
                                  color: Colors.black26

                                ),
                              ),

                              GestureDetector(
                                onTap: ()=>{},
                                child: Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: MyColors.secondary,

                                  ),
                              ),

                            ],
                          )
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
                    decoration: BoxDecoration(
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
                                                child: Text("Tüm Kiralamalarım",style: TextStyle(fontSize: MyFontSizes.fontSize_0(context))),
                                                onPressed: () {
                                                  setState(() {
                                                    // Button'a tıklanınca yapılacak işlemler
                                                  });
                                                },
                                                //size: 'xsmall',
                                                //variant: button['variant'].toString(),
                                              ),
                                            Positioned(
                                                right: 5,
                                                bottom: 15,
                                                child: Icon(Icons.chevron_right,color: MyColors.secondary,size: 20,))
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
                                            child: Text("Ürün & Satıcı Yorumlarım",style: TextStyle(fontSize: MyFontSizes.fontSize_0(context))),
                                            onPressed: () {
                                              setState(() {
                                                // Button'a tıklanınca yapılacak işlemler
                                              });
                                            },
                                            //size: 'xsmall',
                                            //variant: button['variant'].toString(),
                                          ),
                                          Positioned(
                                              right: 0,
                                              bottom: 15,
                                              child: Icon(Icons.chevron_right,color: MyColors.secondary,size: 20,))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 35
                                ),
                                itemCount: buttonData.length,
                                itemBuilder: (context, index) {
                                  final button = buttonData[index];
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ElevatedButton(
                                        child: Text(button['label'].toString(),style: TextStyle(fontSize: MyFontSizes.fontSize_0(context)),),
                                        onPressed: () {
                                          setState(() {
                                            // Button'a tıklanınca yapılacak işlemler
                                          });
                                        },
                                        //size: 'xsmall',
                                        //variant: button['variant'].toString(),
                                      ),
                                      Positioned(
                                          right: 10,
                                          bottom: 10,
                                          child: Icon(Icons.chevron_right,color: MyColors.secondary,size: 20,))
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: MyColors.background
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("Destek",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: MyFontSizes.fontSize_2(context),
                                color: Colors.black45)),
                      ),
                      Divider(
                        height: 20, // Çizginin yüksekliği (isteğe bağlı)
                        thickness: 0.5, // Çizginin kalınlığı (isteğe bağlı)
                        color: Colors.black, // Çizginin rengi (isteğe bağlı)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Row(
                              children: [
                                Icon(Icons.star_rate_outlined,size: 20,color: MyColors.secondary),
                                SizedBox(width: 10,),
                                Text("Uygulamayı Değerlendir"),],),
                            Icon(Icons.chevron_right,color: MyColors.secondary,size: 20,)
                          ],),
                      ),
                      Divider(
                        height: 20, // Çizginin yüksekliği (isteğe bağlı)
                        thickness: 0.05, // Çizginin kalınlığı (isteğe bağlı)
                        color: Colors.black, // Çizginin rengi (isteğe bağlı)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.help_outline_sharp,size: 20,color: MyColors.secondary,),
                                SizedBox(width: 10,),
                                Text("Yardım & Sıkça Sorulan Sorular"),],),
                            Icon(Icons.chevron_right,color: MyColors.secondary,size: 20,)
                          ],),
                      ),
                      Divider(
                        height: 20, // Çizginin yüksekliği (isteğe bağlı)
                        thickness: 0.05, // Çizginin kalınlığı (isteğe bağlı)
                        color: Colors.black, // Çizginin rengi (isteğe bağlı)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.support_agent,size: 20,color: MyColors.secondary),
                                SizedBox(width: 10,),
                                Text("Asistan"),],),
                            Icon(Icons.chevron_right,color: MyColors.secondary,size: 20,)
                          ],),
                      ),


                    ],
                  ),

                )






              ],
            ),
          ),
        )
      )
    );
  }
}
