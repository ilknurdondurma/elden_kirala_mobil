import 'package:elden_kirala/components/text/text.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/models/category-model/category-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constanst/colors.dart';
import '../../../models/brand-model/brand-model.dart';

class Carousel extends StatelessWidget {
  final List<dynamic> items;

  const Carousel({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 0,left: 0,right: 8,top: 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: MyColors.tertiary),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                gradient: LinearGradient(colors: [MyColors.secondary,Colors.deepPurple,Colors.deepPurpleAccent],)
              ),
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.width / 12,
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 1,
                  //heightFactor: 0.5,
                  child: Text(
                      item.name.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MyFontSizes.fontSize_0(context),
                      color: Colors.white

                    ),
                  )
                ),
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }
}
