import 'package:flutter/material.dart';

import '../../../layout/appbar/appbar.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        //appBar: CustomAppBar(),
        body:Center(
            child: Text("securiy")
        )
    );
  }
}
