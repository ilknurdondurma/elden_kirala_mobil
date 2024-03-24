import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../constanst/colors.dart';
import '../../constanst/containerSizes.dart';
import '../../constanst/fontSize.dart';
import '../../models/product-model/product-model.dart';
import '../text/text.dart';

class ProductContainer extends StatelessWidget {
  final Product product;

  const ProductContainer({super.key, required this.product});

  goDetailHandle() {
    Get.toNamed('/detail/${product.productId}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goDetailHandle(),
      child: Container(
        height: MyContainerSizes.heightSize(context, 0.35),
        width: MyContainerSizes.widthSize(context, 0.30),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: MyColors.tertiary),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
      
                Expanded(
                  child: Image.memory(
                    base64Decode(product.filE_URL_1.toString().split(',').last),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(product.name.toString(),
                  style: TextStyle(
                      fontSize: MyFontSizes.fontSize_1(context)),
                  maxLines: 1,
                  textAlign: TextAlign.center,),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(product.price.toString(),
                      style: TextStyle(
                          color: MyColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: MyFontSizes.fontSize_0(context)),
                      maxLines: 1,
                      textAlign: TextAlign.center,),
                    Text(" TL / MONTH",style: TextStyle(
                        color: MyColors.secondary
                    ),)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class VerticalCarousel extends StatefulWidget {
  final List<Widget> items;
  final Duration duration;
  final Curve curve;

  VerticalCarousel({
    required this.items,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
  });

  @override
  _VerticalCarouselState createState() => _VerticalCarouselState();
}

class _VerticalCarouselState extends State<VerticalCarousel> {
  late int _currentIndex;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.duration + Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.items.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: widget.duration,
                curve: widget.curve,
                transform: Matrix4.translationValues(0.0, (_currentIndex - index) * MediaQuery.of(context).size.height * 0.5, 0.0),
                child: widget.items[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
