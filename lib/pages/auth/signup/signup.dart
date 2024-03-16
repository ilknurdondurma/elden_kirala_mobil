import 'package:elden_kirala/components/buttons/button.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:elden_kirala/layout/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../validate/validator.dart';


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
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) => FormValidator.requiredField(value, 'email') ?? FormValidator.emailField(value),

            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value) => FormValidator.requiredField(value, 'password'),
            ),
            const SizedBox(height: 20.0),
            Button(
              onPressed: ()=>null,
              label: "Login",
              size: "normal",
              variant: "Purple",),
            GestureDetector(
                onTap: ()=>Get.offAllNamed("/login"),
                child: Text("Hesabın Var mı ? Hemen Giriş Yap",))
          ],
        ),
      ),
    );
  }
}
