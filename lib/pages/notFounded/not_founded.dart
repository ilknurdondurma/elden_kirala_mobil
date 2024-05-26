import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../layout/appbar/appbar.dart';

class NotFounded extends StatefulWidget {
  const NotFounded({super.key});

  @override
  State<NotFounded> createState() => _HomeState();
}

class _HomeState extends State<NotFounded> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBar(),
      body: Container(
        child: const Text("notfounded"),
      ),
    );
  }
}
