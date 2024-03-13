import 'package:elden_kirala/constanst/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../layout/appbar/appbar.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBarInPage(title: MyTexts.details,),
      body: Container(
        child: Text("detailss"),
      ),
    );
  }
}
