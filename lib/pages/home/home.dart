import 'package:elden_kirala/components/carousel/normal/normal.dart';
import 'package:elden_kirala/components/text/text.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:elden_kirala/constanst/texts.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../api/api.dart';
import '../../components/gridView/gridView.dart';
import '../../components/highlightCard/highlightCard.dart';
import '../../components/progressIndicator/progressIndicator.dart';
import '../../models/brand-model/brand-model.dart';
import '../../models/product-model/product-model.dart';
import '../../models/category-model/category-model.dart';
import '../../services/fetcher.dart';
final box = GetStorage();


class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];
  List<Brand> brands = [];
  List<Categories> categories = [];
  late Fetcher productFetcher;
  late Fetcher brandFetcher;
  late Fetcher categoryFetcher;
  late String userId = box.read('user')['id'].toString();
  final TextEditingController _searchController = TextEditingController();
  bool _isCategoriesExpanded = false;

  @override
  void initState() {
    super.initState();
    productFetcher = Fetcher(
        Product.fromJson, _setProducts, () => Api.getAllProducts(userId));
    brandFetcher =
        Fetcher(Brand.fromJson, _setBrands, () => Api.getAllBrand());
    categoryFetcher = Fetcher(
        Categories.fromJson, _setCategories, () => Api.getCategories());

    productFetcher.fetchData();
    brandFetcher.fetchData();
    categoryFetcher.fetchData();
  }

  void _setProducts(List<dynamic> data) {
    setState(() {
      products = data.cast<Product>();
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
      productFetcher = Fetcher(
          Product.fromJson, _setProducts, () => Api.getAllProducts(userId));
    } else {
      productFetcher = Fetcher(Product.fromJson, _setProducts,
              () => Api.getProductsByCategoryId(categoryId));
    }
    productFetcher.fetchData();
  }

  void _updateProductByBrand(int brandId) {
    if (brandId == -1) {
      productFetcher = Fetcher(
          Product.fromJson, _setProducts, () => Api.getAllProducts(userId));
    } else {
      productFetcher = Fetcher(Product.fromJson, _setProducts,
              () => Api.getProductsByBrandId(brandId));
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
                height: MyContainerSizes.heightSize(context, 0.05),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isCategoriesExpanded = !_isCategoriesExpanded;
                        });
                      },
                      child: const Text(MyTexts.categories),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: null,
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
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
            if (_isCategoriesExpanded)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    title: Text(categories[index].name),
                    children: categories[index]
                        .subCategories
                        .map((subCategory) => ListTile(
                      title: Text(subCategory.name),
                      onTap: () {
                        _updateProductsByCategory(subCategory.id);
                        Navigator.pop(context); // Drawer'ı kapat
                      },
                    ))
                        .toList(),
                  );
                },
              ),
            //kategoriler
            Carousel(
                items: categories,
                border: true,
                onItemSelected: _updateProductsByCategory),

            const MyText(text: "Markaları Keşfet"),
            //markalar
            Carousel(
              items: brands,
              onItemSelected: _updateProductByBrand,
              isHaveImage: true,
              border: false,
              countOfWidth: 7,
            ),
            MyText(
              text: "Vitrini Keşfet",
              fontSize: MyFontSizes.fontSize_3(context),
            ),
            // vitrin
            const HighlightCard(imagePath: "assets/vitrin.jpeg"),
            GestureDetector(
              onTap: () => {print(box.read("user"))},
              child: const Text(
                "bak",
              ),
            ),
            const MyText(text: "Tüm Ürünleri Keşfet"),
            //ürünler
            products.isEmpty && productFetcher.isLoading
                ? IndicatorProgressBar()
                : products.isEmpty
                ? const Center(child: MyText(text: "Ürün bulunamadı"))
                : CustomGridView(
              products: products,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(categories[index].name),
              onTap: () {
                _updateProductsByCategory(categories[index].id);
                Navigator.pop(context); // Drawer'ı kapat
              },
            );
          },
        ),
      ),
    );
  }
}





