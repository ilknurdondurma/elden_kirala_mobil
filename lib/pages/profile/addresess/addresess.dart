import 'package:flutter/material.dart';

import '../../../layout/appbar/appbar.dart';

class Addresess extends StatefulWidget {
  const Addresess({super.key});

  @override
  State<Addresess> createState() => _AddresessState();
}

class _AddresessState extends State<Addresess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: CustomAppBar(),
        body:Center(
            child: Text("addresess")
        )
    );
  }
}
