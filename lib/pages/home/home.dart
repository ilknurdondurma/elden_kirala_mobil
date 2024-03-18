import 'package:elden_kirala/components/buttons/button.dart';
import 'package:elden_kirala/components/carousel/normal/normal.dart';
import 'package:elden_kirala/components/text/text.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api/api.dart';
import '../../components/carousel/circular/carousel.dart';
import '../../components/gridView/gridView.dart';
import '../../components/highlightCard/highlightCard.dart';
import '../../constanst/colors.dart';
import '../../models/brand-model/brand-model.dart';
import '../../models/product-model/product-model.dart';
import '../../models/category-model/category-model.dart';
import '../../services/fetcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];
  List<Brand> brands = [];
  List<Categories>categories=[];
  late Fetcher productFetcher;
  late Fetcher brandFetcher;
  late Fetcher categoryFetcher;

  @override
  void initState() {
    super.initState();

    productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getAllProducts(12));
    brandFetcher = Fetcher(Brand.fromJson, _setBrands, () => Api.getAllBrand());
    categoryFetcher = Fetcher(Categories.fromJson, _setCategories, () => Api.getCategories());

    productFetcher.fetchData();
    brandFetcher.fetchData();
    categoryFetcher.fetchData();
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

  void _setCategories(List<dynamic> data) {
    setState(() {
      categories = data.cast<Categories>(); // CATEGORY tipine dönüştürme
    });
  }
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MyContainerSizes.heightSize(context, 0.05), // TextField'ın yüksekliğini ayarlar
                child: Row(
                  children: [
                    Button(
                      onPressed: ()=>null,
                      label: "Tüm Kategoriler",
                      variant: "PurpleOutline",
                      size: "xsmall",
                    ),
                    SizedBox(width: 10,),
                    Expanded( // TextField widget'ını esnek genişlikli (expanded) yapar
                      child: Container(
                        child: TextField(
                          controller: _searchController,
                          onChanged: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12), // İçeriğin etrafındaki boşluğu ayarlar
                            hintText: 'Aramak istediğiniz şeyi girin...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Carousel(items: categories,),





            MyText(text: "Markaları Keşfet") ,
        //markalar
            CircularCarousel(items: brands),
             MyText(text: "Vitrini Keşfet",fontSize: MyFontSizes.fontSize_3(context),) ,
        // vitrin
            HighlightCard(imagePath: "assets/vitrin.jpeg"),
            MyText(text: "Tüm Ürünleri Keşfet") ,
            //ürünler
            products.isEmpty
                ? const Center(child: MyText(text:"Ürün bulunamadı..."))
                : CustomGridView(
                    products: products,
            ),
          ],
        ),
      ),
    );
  }


}


