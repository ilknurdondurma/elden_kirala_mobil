import 'package:flutter/material.dart';
import 'package:elden_kirala/components/buttons/button.dart';
import 'package:elden_kirala/components/textField/custom_input_field.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:elden_kirala/layout/appbar/appbar.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../../../api/api.dart';
import '../../../controller/auth-controller/auth-controller.dart';
final box = GetStorage();

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: CustomAppBarLogout(title: "Giriş Yap"),
        body: SignupForm(),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _usersurnameController = TextEditingController();

  late final String countryValue;
  late final String stateValue;
  late final String cityValue;
  late final AuthController _authController;


  Future<void> handleSubmit() async {

    try {
      print("city"+cityValue);
      print("dist"+stateValue);


      var user={
        "name":_usernameController.text,
        "surname":_usersurnameController.text,
        "password":_passwordController.text,
        "email":_emailController.text,
        "rating":5.0,
        "city":cityValue,
        "district":stateValue,
        "userType":"Kiracı",
        "fullAddress":""
      };

      dio.Response response = await Api.signUp(user);
      if (response.statusCode == 200) {
        print("İstek başarıyla gönderildi. Yanıt: ${response.data}");
        Map<String, dynamic> responseData = response.data['data'];
        await box.write('user', responseData);
        print(box.read('user'));
        Get.offAllNamed("/");
      }
    } catch (e) {
      print("İstek sırasında bir hata oluştu");
      ScaffoldMessenger.of(context,).showSnackBar(
        SnackBar(
          content: Text("error "),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo.png'),
                const SizedBox(height: 20,),
                Text(MyTexts.name, style: TextStyle(fontSize: MyFontSizes.fontSize_3(context))),
                const SizedBox(height: 30,),
                CustomTextField(controller: _usernameController, label: "Adınız",),
                CustomTextField(controller: _usersurnameController, label: "Soyadınız",),

                Column(
                  children: [
                    SelectState(
                      // style: TextStyle(color: Colors.red),
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged:(value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged:(value) {
                        setState(() {
                          cityValue = value;
                        });
                      },

                    ),
                    // InkWell(
                    //   onTap:(){
                    //     print('country selected is $countryValue');
                    //     print('country selected is $stateValue');
                    //     print('country selected is $cityValue');
                    //   },
                    //   child: Text(' Check')
                    // )
                  ],
                ),
                CustomTextField(controller: _emailController, label: "Email",),
                CustomTextField(controller: _passwordController, label: "Şifre",),
                const SizedBox(height: 20.0),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) handleSubmit();
                  },
                  label: "Üye Ol",
                  size: "normal",
                  variant: "Purple",
                ),
                GestureDetector(
                  onTap: () => Get.offAllNamed("/login"),
                  child: const Text("Hesabın Var mı? Hemen Giriş Yap"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const List<String> cities = [
  "Adana",
  "Adıyaman",
  "Afyonkarahisar",
  "Ağrı",
  "Aksaray",
  "Amasya",
  "Ankara",
  "Antalya",
  "Ardahan",
  "Artvin",
  "Aydın",
  "Balıkesir",
  "Bartın",
  "Batman",
  "Bayburt",
  "Bilecik",
  "Bingöl",
  "Bitlis",
  "Bolu",
  "Burdur",
  "Bursa",
  "Çanakkale",
  "Çankırı",
  "Çorum",
  "Denizli",
  "Diyarbakır",
  "Düzce",
  "Edirne",
  "Elazığ",
  "Erzincan",
  "Erzurum",
  "Eskişehir",
  "Gaziantep",
  "Giresun",
  "Gümüşhane",
  "Hakkari",
  "Hatay",
  "Iğdır",
  "Isparta",
  "İstanbul",
  "İzmir",
  "Kahramanmaraş",
  "Karabük",
  "Karaman",
  "Kars",
  "Kastamonu",
  "Kayseri",
  "Kırıkkale",
  "Kırklareli",
  "Kırşehir",
  "Kilis",
  "Kocaeli",
  "Konya",
  "Kütahya",
  "Malatya",
  "Manisa",
  "Mardin",
  "Mersin",
  "Muğla",
  "Muş",
  "Nevşehir",
  "Niğde",
  "Ordu",
  "Osmaniye",
  "Rize",
  "Sakarya",
  "Samsun",
  "Şanlıurfa",
  "Siirt",
  "Sinop",
  "Şırnak",
  "Sivas",
  "Tekirdağ",
  "Tokat",
  "Trabzon",
  "Tunceli",
  "Uşak",
  "Van",
  "Yalova",
  "Yozgat",
  "Zonguldak"
];
