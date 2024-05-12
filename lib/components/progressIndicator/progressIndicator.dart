import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class IndicatorProgressBar extends StatelessWidget {
  const IndicatorProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: const Color(0xFF61D4AF),
        rightDotColor: const Color(0xFF673ab7),
        size: 20,
      ),
    );
  }
}