import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Duration duration;

  const CustomSnackBar({
    Key? key,
    required this.message,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: duration,
    );
  }
}
