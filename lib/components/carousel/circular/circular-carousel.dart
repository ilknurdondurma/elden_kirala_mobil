import 'package:elden_kirala/constanst/colors.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  final List<Widget> items;

  const CustomCarousel({Key? key, required this.items}) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8, // Adjust as needed
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Vitrin",
            style: TextStyle(
              color: Colors.black54,
              fontSize: MyFontSizes.fontSize_3(context),
              //letterSpacing: 5,
              //fontFamily: 'MyFontFamily',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
            ),
          ),
          Container(
            height: MyContainerSizes.heightSize(context, 0.1), // Adjust height as needed
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal, // Ensure horizontal scrolling
              physics: BouncingScrollPhysics(), // Add bouncing scroll physics
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return ClipOval(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: widget.items[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
