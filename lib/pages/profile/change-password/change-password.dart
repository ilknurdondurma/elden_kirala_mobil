import 'package:flutter/material.dart';

import '../../../layout/appbar/appbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appBar: CustomAppBar(),
        body:Center(
            child: Text("change pass")
        )
    );
  }
}
