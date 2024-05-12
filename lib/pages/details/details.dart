import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../api/api.dart';
import '../../components/detailsCard/detailsCard.dart';
import '../../components/progressIndicator/progressIndicator.dart';
import '../../components/text/text.dart';
import '../../layout/appbar/appbar.dart';
import '../../models/product-model/product-model.dart';
import '../../services/fetcher.dart';

final box = GetStorage();

class Details extends StatefulWidget {
  final int? id;

  const Details({super.key, this.id});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<Product> product = [];
  late Fetcher productFetcher;
  int index=0;

  @override
  void initState() {
    super.initState();
    late int userId = box.read('user')['id'].toInt();
    late int productId = int.parse(Get.parameters['id']!);
    productFetcher = Fetcher(Product.fromJson, _setProducts,
            () => Api.getProductsById(productId, userId));
    productFetcher.fetchData();
  }
  void _setProducts(List<dynamic> data) {
    setState(() {
      product = data.cast<Product>();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarInPage(title: product.isNotEmpty ? product.first.name : ''),

      body:  product.isEmpty && productFetcher.isLoading // API'den veri bekleniyor
          ? IndicatorProgressBar()
          : product.isEmpty // Ürün bulunamadı
                ? const Center(child: MyText(text: "Ürün bulunamadı"),)
                :DetailCard(product: product.first),

    );
  }
}

