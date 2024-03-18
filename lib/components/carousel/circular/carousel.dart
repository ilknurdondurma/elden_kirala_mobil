import 'package:flutter/material.dart';
import '../../../models/brand-model/brand-model.dart';

class CircularCarousel extends StatelessWidget {
  final List<Brand> items;

  const CircularCarousel({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 8,
            height: MediaQuery.of(context).size.width / 8,
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: 1,
                child: Image.network(item.logo.toString(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}
