import 'dart:convert';

import 'package:elden_kirala/constanst/colors.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../api/api.dart';
import '../../components/productCard/productCard.dart';
import '../../models/product-model/product-model.dart';
import '../../services/product_fetcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];
  late Fetcher productFetcher;

  @override
  void initState() {
    super.initState();
    productFetcher = Fetcher(
      Product.fromJson,
      _setProducts,
          () => Api.getAllProducts(12),
    );

    productFetcher.fetchData();
  }
  void _setProducts(List<dynamic> data) {
    setState(() {
      products = data.cast<Product>(); // Product tipine dönüştürme
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Buraya eklemek istediğiniz diğer bileşenleri ekleyebilirsiniz
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Diğer Bileşen',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? Center(child: Text("Ürün bulunamadı..."))
                : buildGridView(context),
          ),
        ],
      ),
    );
  }

  Padding buildGridView(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _crossAxisCount(context),
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
          return ProductContainer(product: products[index]);
                  },
                ),
        );
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
}
