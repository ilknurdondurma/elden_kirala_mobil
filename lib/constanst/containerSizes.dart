import 'package:flutter/material.dart';

class MyContainerSizes {

  static widthSize(BuildContext context,double? rate ) => MediaQuery.of(context).size.width*(rate??0.3).toDouble();
  static heightSize(BuildContext context,double? rate) => MediaQuery.of(context).size.height*(rate??0.3).toDouble();
  static fontSize_3(BuildContext context) => MediaQuery.of(context).size.width*0.06.toDouble();


}