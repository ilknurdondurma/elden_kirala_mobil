import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elden_kirala/components/buttons/button.dart';
import 'package:elden_kirala/components/dropdown/dropdown.dart';
import 'package:elden_kirala/components/textField/custom_input_field.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:elden_kirala/layout/appbar/appbar.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

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
  final _userCityController = TextEditingController();
  final _userDistrictController = TextEditingController();

  late final String countryValue;
  late final String stateValue;
  late final String cityValue;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    CustomTextField(controller: _userDistrictController, label: "İlçe", width: 0.4,),
                  ],
                ),
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
                Button(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Kaydetme işlemi
                    }
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
