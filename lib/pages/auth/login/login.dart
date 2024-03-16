
import 'package:dio/dio.dart';
import 'package:elden_kirala/components/buttons/button.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:elden_kirala/layout/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:dio/src/form_data.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../api/api.dart';
import '../validate/validator.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: CustomAppBarLogout(title: "Giriş Yap"),
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  _LoginFormState createState() => _LoginFormState();
}


class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  handleSubmit(String email, String password) async {
    try {
          FormData formData = FormData.fromMap({
            'email': email,
            'pass': password
          });
          Response response = await Api.login(formData);
          if (response.statusCode == 200) {
            print("İstek başarıyla gönderildi. Yanıt: ${response.data}");
          } else {
            print("İstek başarısız oldu. Hata kodu: ${response.statusCode}");
          }
    }
    catch (e) {
           print("İstek sırasında bir hata oluştu: $e");
    }
  }

  @override

  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            const SizedBox(height: 20,),
            Text(MyTexts.name,style: TextStyle(fontSize: MyFontSizes.fontSize_3(context))),
            const SizedBox(height: 30,),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                final emailError = FormValidator.requiredField(value, 'email') ?? FormValidator.emailField(value);
                return emailError;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                final passError = FormValidator.requiredField(value, 'password');
                return passError;
              },
            ),
            const SizedBox(height: 20.0),
            Button(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Perform login here
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  print('Username: $email');
                  print('Password: $password');
                  await handleSubmit(email,password);
                }
              },
              label: "Login",
              size: "normal",
              variant: "Purple",),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: ()=> Get.offAllNamed("/signup"),
                child: const Text("Hesabın Yok mu ? Hemen Üye ol",)),

          ],
        ),
      ),
    );
  }
}
