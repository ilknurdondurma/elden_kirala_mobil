import 'package:elden_kirala/components/buttons/button.dart';
import 'package:elden_kirala/components/carousel/normal/normal.dart';
import 'package:elden_kirala/components/text/text.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../api/api.dart';
import '../../components/gridView/gridView.dart';
import '../../components/highlightCard/highlightCard.dart';
import '../../controller/auth-controller/auth-controller.dart';
import '../../models/brand-model/brand-model.dart';
import '../../models/product-model/product-model.dart';
import '../../models/category-model/category-model.dart';
import '../../services/fetcher.dart';
final box = GetStorage();

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
  late String userId=box.read('user')['id'].toString();


  final TextEditingController _searchController = TextEditingController();
  final AuthController _authController = Get.find();

  @override
  void initState() {
    super.initState();

    productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getAllProducts(userId));
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

  void _updateProductsByCategory(int categoryId)  {
    if(categoryId==-1) {
      productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getAllProducts(userId));
    }
    else {
      productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getProductsByCategoryId(categoryId));
    }
    productFetcher.fetchData();
  }


  void _updateProductByBrand(int brandId) {
    if(brandId==-1) {
      productFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getAllProducts(userId));
    }
    else {
      productFetcher=Fetcher(Product.fromJson, _setProducts, () => Api.getProductsByBrandId(brandId));
    }
    productFetcher.fetchData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        //arama
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MyContainerSizes.heightSize(context, 0.05), // TextField'ın yüksekliğini ayarlar
                child: Row(
                  children: [
                    Button(
                      onPressed: () {
                          print("*********************************userimiz:*******************************************");
                          var user=box.read('user');
                          print(user['name']);
                          print(user['token']);
                          print(user['id']);
                          print("********************************giriş durumumuz:************************************");
                          print(_authController.isAuthenticated);


                        },
                      label: MyTexts.categories,
                      variant: "PurpleOutline",
                      size: "xsmall",
                    ),
                    const SizedBox(width: 10,),
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
              ),
            ),
        //kategoriler
            Carousel(
                items: categories,
                border: true,
                onItemSelected: _updateProductsByCategory),

            const MyText(text: "Markaları Keşfet") ,
        //markalar
            Carousel(
              items: brands,
              onItemSelected: _updateProductByBrand,
              isHaveImage: true,
              border: false,
              countOfWidth: 7,
            ),
             MyText(text: "Vitrini Keşfet",fontSize: MyFontSizes.fontSize_3(context),) ,
        // vitrin
            const HighlightCard(imagePath: "assets/vitrin.jpeg"),
            const MyText(text: "Tüm Ürünleri Keşfet") ,
            //ürünler
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
      ),
    );
  }


}


