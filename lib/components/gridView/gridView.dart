import 'package:elden_kirala/components/productCard/productCard.dart';
import 'package:flutter/material.dart';
import '../../models/product-model/product-model.dart';

class CustomGridView extends StatelessWidget {
  final int? crossAxisCount;
  final List<Product> products;

  const CustomGridView({
    Key? key,
     this.crossAxisCount,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount??_crossAxisCount(context),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 20.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductContainer(product: products[index]);
        },
      ),
    );
  }
}

int _crossAxisCount(BuildContext context) {
  // Calculate the number of items per row based on screen width
  final screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 1200) {
    return 4;
  } else if (screenWidth > 800) {
    return 3;
  } else {
    return 2;
  }
}