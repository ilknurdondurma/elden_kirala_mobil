import 'package:elden_kirala/constanst/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget{
  final VoidCallback onPressed;
  final String label;
  final String? variant;
  final String? size;
  final Widget? child;

  const Button({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant,
    this.size,
    this.child
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          _getColor(variant!),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(color: Colors.white),
        ),
        elevation: MaterialStateProperty.all<double>(4.0),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: _getBorderColor(variant!),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(_getSize(size!)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,style: TextStyle(
                color: _getTextColor(variant!),
                fontSize: _getTextSize(size!)),
                textAlign: TextAlign.center,),
            if (child != null) const SizedBox(width: 8), // Add a SizedBox if child is provided
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
Color _getColor(String variant) {
  switch (variant) {
    case 'Green':
      return MyColors.primary;

    case 'Purple':
      return MyColors.secondary;

    case 'GreenOutline':
      return Colors.white;

    case 'PurpleOutline':
      return Colors.white;

    default:
      return MyColors.primary;
  }
}
Color _getBorderColor(String variant) {
  switch (variant) {
    case 'Green':
      return Colors.white;

    case 'Purple':
      return Colors.white;

    case 'GreenOutline':
      return MyColors.primary;

    case 'PurpleOutline':
      return MyColors.secondary;

    default:
      return Colors.white;
  }
}
Color _getTextColor(String variant) {
  switch (variant) {
    case 'Green':
    case 'Purple':
      return Colors.white;
    case 'PurpleOutline':
      return MyColors.secondary;
    case 'GreenOutline':
      return MyColors.primary;
    default:
      return Colors.white;
  }
}
double _getTextSize(String size) {
  switch (size) {
    case 'large':
      return 22.0;
    case 'normal':
      return 20.0;
    case 'small':
      return 18.0;
    case 'xsmall':
      return 14.0;
    default:
      return 20.0;
  }
}
double _getSize(String size) {
  switch (size) {
    case 'large':
      return 12.0;
    case 'normal':
      return 10.0;
    case 'small':
      return 8.0;
    case 'xsmall':
      return 0.0;
    default:
      return 10.0;
  }
}