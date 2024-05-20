import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../components/buttons/button.dart';
import '../../../constanst/colors.dart';
import '../../../constanst/fontSize.dart';
import '../../../layout/appbar/appbar.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  final List<Map<dynamic, dynamic>> buttonData = [
    {'id': "1",  'label': 'Email','desc':'Kampanyalarla ilgili e-posta almak istiyorum.','isChecked': false},
    {'id': "2", 'label': 'SMS' ,'desc':'Kampanyalarla ilgili SMS almak istiyorum.','isChecked': false},
    {'id': "3", 'label': 'Uygulama Bildirimleri','desc':'Kampanyalarla ilgili bildirim almak istiyorum.','isChecked': true },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarInPage(
        title: "Bildirim Tercihlerim",
        showLeadingIcon: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: MyContainerSizes.widthSize(context, 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 50),
                    itemCount: buttonData.length,
                    itemBuilder: (context, index) {
                      final button = buttonData[index];
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: MyColors.tertiary.withOpacity(0.3)
                            ),
                            child: Column(
                              mainAxisAlignment :MainAxisAlignment.center,
                              children: [
                                Text(
                                  button['label'].toString(),
                                  style: TextStyle(
                                      fontSize: MyFontSizes.fontSize_0(context),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  button['desc'].toString(),
                                  style: TextStyle(
                                    fontSize: MyFontSizes.fontSize_0(context),
                                    color: Colors.black54,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                           Positioned(
                              right: 20,
                              //bottom: -5,
                              child: Checkbox(
                                checkColor:Colors.white,
                                activeColor:  MyColors.primary,
                                value: button['isChecked'] ?? false,
                                onChanged: (bool? value) {
                                  setState(() {
                                    button['isChecked'] = value ?? false;
                                  });
                                },
                              ),),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20,),
                  Button(
                    onPressed: _handleSubmit,
                    label: "Güncelle",
                    variant: "Green",
                    size: "small",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    Get.back();
  }
}
