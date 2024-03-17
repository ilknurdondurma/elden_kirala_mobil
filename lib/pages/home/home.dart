import 'package:flutter/material.dart';
import '../../api/api.dart';
import '../../components/carousel/circular/circular-carousel.dart';
import '../../components/productCard/productCard.dart';
import '../../constanst/colors.dart';
import '../../models/brand-model/brand-model.dart';
import '../../models/product-model/product-model.dart';
import '../../services/product_fetcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];
  List<Brand> brands = [];
  late Fetcher productFetcherProducts;
  late Fetcher productFetcherBrands;

  @override
  void initState() {
    super.initState();

    // Products fetcher
    productFetcherProducts = Fetcher(
      Product.fromJson,
      _setProducts,
          () => Api.getAllProducts(12),
    );
    productFetcherProducts.fetchData();

    // Brands fetcher
    productFetcherBrands = Fetcher(
      Brand.fromJson,
      _setBrands,
          () => Api.getAllBrand(),
    );
    productFetcherBrands.fetchData();
  }

  void _setProducts(List<dynamic> data) {
    setState(() {
      products = data.cast<Product>(); // Product tipine dönüştürme
    });
  }

  void _setBrands(List<dynamic> data) {
    setState(() {
      brands = data.cast<Brand>(); // BRAND tipine dönüştürme
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: brands.map((brand) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Container(

                      width: 62, // Ayarlayın
                      height: 62, // Ayarlayın
                      child: Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          heightFactor: 0.5,
                          child: Image.network(brand.logo.toString(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
            //ürünler
            products.isEmpty
                ? const Center(child: Text("Ürün bulunamadı..."))
                : buildGridView(context),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _crossAxisCount(context),
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 30.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductContainer(product: products[index]);
      },
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
