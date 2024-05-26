import 'package:dio/dio.dart' as dio;
import 'package:elden_kirala/components/buttons/button.dart';
import 'package:elden_kirala/components/textField/custom_input_field.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:elden_kirala/layout/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../api/api.dart';
import '../../../controller/auth-controller/auth-controller.dart';
import '../validate/validator.dart';
final box = GetStorage();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

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
  const LoginForm({Key? key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthController _authController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authController = Get.find(); // AuthController'ı initialize et
  }

  Future<void> handleSubmit(String email, String password) async {
    setState(() {
      _isLoading = true; // Giriş işlemi başladığında isLoading'u true yap
    });
    try {
      dio.FormData formData = dio.FormData.fromMap({'email': email, 'pass': password});
      dio.Response response = await Api.login(formData);
      if (response.statusCode == 200) {
        print("İstek başarıyla gönderildi. Yanıt: ${response.data}");
        Map<String, dynamic> responseData = response.data['data'];
        await box.write('user', responseData);
        print(box.read('user'));
        _authController.login();
        Get.offAllNamed("/");
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Giriş işlemi başladığında isLoading'u true yap
      });
      print("İstek sırasında bir hata oluştu: $e");
      ScaffoldMessenger.of(context,).showSnackBar(
        SnackBar(
          content: Text("Şifren yanlış olabilir "),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/logo.png'),
                  const SizedBox(height: 20),
                  Text(
                    MyTexts.name,
                    style: TextStyle(fontSize: MyFontSizes.fontSize_3(context)),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(controller: _emailController,label: "Email",),
                  CustomTextField(controller: _passwordController , label: "Password",),
                  const SizedBox(height: 20),
                  Button(
                    onPressed: _isLoading
                        ? () {}
                        : () {
                      if (_formKey.currentState!.validate()) {
                        // Perform login here
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        print('Username: $email');
                        print('Password: $password');
                        handleSubmit(email, password);
                      }
                    },
                    label: "Login",
                    size: "normal",
                    variant: "Purple",
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Get.offAllNamed("/signup"),
                    child: const Text(
                      "Hesabın Yok mu ? Hemen Üye ol",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


