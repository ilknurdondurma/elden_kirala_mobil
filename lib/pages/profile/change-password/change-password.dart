import 'package:elden_kirala/components/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../api/api.dart';
import '../../../components/textField/custom_input_field.dart';
import '../../../layout/appbar/appbar.dart';
final box = GetStorage();


class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final int userId = box.read("user")["id"];
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordRepeat = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validatePasswords() {
    if (_password.text != _passwordRepeat.text) {
      return 'Şifreler eşleşmiyor';
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {

      print('Passwords match. Proceed with password change.');
      try{
        Map<String , dynamic> updatedPass={
          "password":_passwordRepeat.text
        };
        dio.Response response = await Api.updateUser(userId,updatedPass);
        if ( response.statusCode==200){
          print("İstek başarıyla gönderildi. Yanıt: ${response.data}");
          ScaffoldMessenger.of(context,).showSnackBar(
            SnackBar(
              content: Text("Şifre başarıyla değiştirildi."),
              duration: Duration(seconds: 2),
            ),
          );
          Map <String , dynamic> responseData = response.data['data'];
          await box.write('user', responseData);
          Get.reload();
          Get.back();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarInPage(
        title: "Şifre Değiştir",
        showLeadingIcon: false,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomTextField(
                        controller: _password,
                        //placeholder: "Yeni şifre",
                        label: "Yeni Şifre",
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bu alanı doldurmak zorunludur';
                          }
                          else if (value.length < 8) {
                            return 'Şifre en az 8 karakter olmalıdır';
                          }
                          /*else if (!RegExp(r'[A-ZÇĞİÖŞÜ]').hasMatch(value)) {
                            return 'Şifre en az bir büyük harf içermelidir';
                          }*/
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: CustomTextField(
                        controller: _passwordRepeat,
                        //placeholder: "Yeni Şifreyi Onayla",
                        label: "Yeni Şİfreyi Onayla",
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bu alanı doldurmak zorunludur';
                          }
                          return _validatePasswords();
                        },
                      ),
                    ),
                    CustomButton(
                      onPressed: _handleSubmit,
                      label: "Kaydet",
                      variant: "Green",
                      size: "small",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
