import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../models/product-model/product-model.dart';
import '../../services/api/api.dart';
import '../../services/fetch-data.dart';

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
      "http://192.168.0.16:8081/api/v2/Product/get-all/12",
      Product.fromJson,
      _setProducts,
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
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name.toString()),
            subtitle: Text(products[index].description.toString()),
            trailing: Text('\$${products[index].price.toString()}'),
          );
        },
      ),






    );
  }
}
