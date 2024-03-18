import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? fontSize;
  final int? maxLines;
  final String? alignment;
  final FontWeight? fontWeight;

  const MyText({
    Key? key,
    required this.text,
    this.verticalPadding,
    this.horizontalPadding,
    this.alignment,
    this.fontSize,
    this.fontWeight, this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 8,
        vertical: verticalPadding ?? 2,
      ),
      child: Row(
        mainAxisAlignment: _getMainAxisAlignment(),
        children: [
          Text(
            text,
            maxLines: maxLines ?? 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize ?? MyFontSizes.fontSize_2(context),
              fontWeight: fontWeight,

            ),
          ),
        ],
      ),
    );
  }

  MainAxisAlignment _getMainAxisAlignment() {
    switch (alignment) {
      case "start":
        return MainAxisAlignment.start;
      case "center":
        return MainAxisAlignment.center;
      case "end":
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.start;
    }
  }
}
