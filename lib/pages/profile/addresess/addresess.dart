import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constanst/colors.dart';
import '../../../layout/appbar/appbar.dart';

final box = GetStorage();

class Addresess extends StatefulWidget {
  const Addresess({super.key});

  @override
  State<Addresess> createState() => _AddresessState();
}

class _AddresessState extends State<Addresess> {

  bool _isEditing = false;
  final TextEditingController  aa=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarInPage(
        title: "Şifre Değiştir",
        showLeadingIcon: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: MyContainerSizes.widthSize(context, 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _handleAddAddresses,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Adres Ekle" ,
                            style: TextStyle(color: MyColors.secondary,fontSize: MyFontSizes.fontSize_2(context))
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.add_location_alt_outlined,color: MyColors.secondary,)
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  _isEditing
                      ? Container(
                          width: MyContainerSizes.widthSize(context, 1),


                  )

                      : Container(
                          width: MyContainerSizes.widthSize(context, 1),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.location_on),
                                      SizedBox(width: 10,),
                                      Icon(Icons.edit ,size: 20,)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(MyTexts.fullName,style: TextStyle(color: Colors.black54),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(MyTexts.email,style: TextStyle(color: Colors.black54),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(MyTexts.city,style: TextStyle(color: Colors.black54),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text(MyTexts.address,style: TextStyle(color: Colors.black54),)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleAddAddresses() {
    print("eklee");
  }
}
