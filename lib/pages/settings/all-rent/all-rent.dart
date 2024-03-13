import 'package:flutter/material.dart';

import '../../../layout/appbar/appbar.dart';

class AllRent extends StatefulWidget {
  const AllRent({super.key});

  @override
  State<AllRent> createState() => _AllRentState();
}

class _AllRentState extends State<AllRent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //appBar: CustomAppBar(),
        body:Center(
            child: Text("all rent")
        )
    );
  }
}
