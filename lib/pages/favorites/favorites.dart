import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../api/api.dart';
import '../../components/gridView/gridView.dart';
import '../../components/text/text.dart';
import '../../constanst/texts.dart';
import '../../models/product-model/product-model.dart';
import '../../services/fetcher.dart';


class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Product> products = [];
  late Fetcher productFetcher;
  final TextEditingController _searchController = TextEditingController();



  void initState() {
    super.initState();
    late String userId=box.read('user')['id'].toString();
    productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getAllFavorites(userId));
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
      //appBar: CustomAppBarInPage(title: MyTexts.favorites,),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            MyText(text: "Favorilerim",alignment: 'center',fontSize: MyFontSizes.fontSize_3(context),) ,
            Row(
              children: [
                Expanded( // TextField widget'ını esnek genişlikli (expanded) yapar
                  child: TextField(
                    controller: _searchController,
                    onChanged: null,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10), // İçeriğin etrafındaki boşluğu ayarlar
                      hintText: MyTexts.search,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            products.isEmpty && productFetcher.isLoading // API'den veri bekleniyor
                ? Center(child: LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF61D4AF),
              rightDotColor: const Color(0xFF673ab7),
              size: 20,
            ),)
                : products.isEmpty // Ürün bulunamadı
                ? Center(child: MyText(text: "Ürün bulunamadı"),)
                : CustomGridView(
              products: products,
            ),

          ],
        ),
      )
    );
  }
}
