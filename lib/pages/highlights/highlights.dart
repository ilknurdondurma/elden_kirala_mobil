import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../api/api.dart';
import '../../components/carousel/normal/normal.dart';
import '../../components/gridView/gridView.dart';
import '../../components/text/text.dart';
import '../../constanst/fontSize.dart';
import '../../constanst/texts.dart';
import '../../layout/appbar/appbar.dart';
import '../../models/brand-model/brand-model.dart';
import '../../models/category-model/category-model.dart';
import '../../models/product-model/product-model.dart';
import '../../services/fetcher.dart';
final box = GetStorage();

class Highlights extends StatefulWidget {
  Highlights({super.key});

  @override
  State<Highlights> createState() => _HighlightsState();
}

class _HighlightsState extends State<Highlights> {
  List<Product> products = [];
  List<Brand> brands = [];
  List<Categories> categories = [];
  late Fetcher productFetcher;
  late Fetcher brandFetcher;
  late Fetcher categoryFetcher;
  late String userId=box.read('user')['id'].toString();


  @override
  void initState() {
    super.initState();

    productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getHighlights(userId));
    brandFetcher = Fetcher(Brand.fromJson, _setBrands, () => Api.getAllBrand());
    categoryFetcher = Fetcher(Categories.fromJson, _setCategories, () => Api.getCategories());

    productFetcher.fetchData();
    brandFetcher.fetchData();
    categoryFetcher.fetchData();
  }

  void _setProducts(List<dynamic> data) {
    setState(() {
      products = data.cast<Product>().where((product) => product.isHighlight == true).toList(); // Product tipine dönüştürme
    });
  }

  void _setBrands(List<dynamic> data) {
    setState(() {
      brands = data.cast<Brand>();
    });
  }

  void _setCategories(List<dynamic> data) {
    setState(() {
      categories = data.cast<Categories>();
    });
  }

  void _updateProductsByCategory(int categoryId) {
    if (categoryId == -1) {
      productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getHighlights(userId));
    }
    else {
      productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getProductsByCategoryId(categoryId));
    }
    productFetcher.fetchData();
  }

  void _updateProductByBrand(int brandId) {
    if (brandId == -1) {
      productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getHighlights(userId));
    }
    else {
      productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getProductsByBrandId(brandId));
    }
    productFetcher.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body:  SingleChildScrollView(
          child: Column(
            children: [
              Carousel(
                  items: categories,
                  border: true,
                  onItemSelected: _updateProductsByCategory),

              //markalar
              Carousel(
                items: brands,
                onItemSelected: _updateProductByBrand,
                isHaveImage: true,
                border: false,
                countOfWidth: 7,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText(text: "Vitrin'e Hoşgeldiniz",alignment: 'center',fontSize: MyFontSizes.fontSize_3(context),),
              ) ,
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
