import 'package:elden_kirala/components/textField/custom_input_field.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../api/api.dart';
import '../../../components/buttons/button.dart';
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
  final int userId = box.read("user")["id"];
  final TextEditingController  address = TextEditingController(text: MyTexts.address);

  Future<void> _handleSubmit() async {

      try{
        Map<String , dynamic> updatedAddr={
          "fullAddress":address.text
        };
        dio.Response response = await Api.updateUser(userId,updatedAddr);
        if ( response.statusCode==200){
          print("İstek başarıyla gönderildi. Yanıt: ${response.data}");
          Map <String , dynamic> responseData = response.data['data'];
          await box.write('user', responseData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('İşlem başarıyla gerçekleştirildi.'),
              duration: Duration(seconds: 2),
            ),
          );
          setState(() {
            _isEditing=false;
          });
        }
      }
      catch (e) {
        print("İstek sırasında bir hata oluştu: $e");
        ScaffoldMessenger.of(context,).showSnackBar(
          SnackBar(
            content: Text("İstek sırasında bir hata oluştu: $e"),
            duration: Duration(seconds: 2),
          ),
        );
      }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarInPage(
        title: "Adres Bilgilerim",
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
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: ()=>{setState(() {
                                        _isEditing=false;
                                      })},
                                      child: Icon(Icons.close ,size: 20,))
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
                                CustomTextField(controller: address,width: 0.8,),
                                CustomButton(
                                  onPressed: _handleSubmit,
                                  label: "Güncelle",
                                  variant: "Green",
                                  size: "small",
                                ),

                               // CustomTextField(controller: controller)
                              ],
                            ),
                          ),


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
                                      GestureDetector(
                                        onTap: ()=>{setState(() {
                                          _isEditing=true;
                                        })},
                                          child: Icon(Icons.edit ,size: 20,))
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
