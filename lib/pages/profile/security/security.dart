import 'package:flutter/material.dart';
import '../../../components/textField/phoneNumberTextField.dart';
import '../../../constanst/colors.dart';
import '../../../constanst/containerSizes.dart';
import '../../../layout/appbar/appbar.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {

  bool isSelected = false;
  final TextEditingController _mobilePhoneController = TextEditingController();

  void toggleSwitch(bool value){
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarInPage(
        title: "Güvenlik",
        showLeadingIcon: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: MyContainerSizes.widthSize(context, 1),
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text("Çift  Faktörlü Korumayı Etkinleştir"),
                            Text("Etkinleştirildiğinde her girişte SMS onayı alır.",style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                          ],
                        ),
                      ),
                      Switch(value: isSelected , onChanged: toggleSwitch,activeColor: MyColors.primary,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Opacity(
                      opacity: isSelected ? 1.0 : 0.5,
                      child: PhoneNumberTextField(initialCountryCode: "TR", controller: _mobilePhoneController, isSelected: isSelected),
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
}


