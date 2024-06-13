import 'dart:convert';

import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../api/api.dart';
import '../../../components/modal/modal.dart';
import '../../../components/progressIndicator/progressIndicator.dart';
import '../../../components/stars/stars.dart';
import '../../../constanst/colors.dart';
import '../../../layout/appbar/appbar.dart';
import '../../../models/comment-model/comment-model.dart';
import '../../../models/product-model/product-model.dart';
import '../../../services/fetcher.dart';

final box = GetStorage();

class ProductComment extends StatefulWidget {
  const ProductComment({super.key});

  @override
  State<ProductComment> createState() => _ProductCommentState();
}
class _ProductCommentState extends State<ProductComment> {

  int selectedIndex = 0; // Tıklanan indeks
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:CustomAppBarInPage(
          title: "Değerlendirmelerim",
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: MyColors.tertiary.withOpacity(0),
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print("a");
                        setState(() {
                          selectedIndex = 0; // Buton 1'e tıklandığında indeksi güncelle
                        });
                        _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                        },
                      child: Text('Ürün Yorumları',
                        style: TextStyle(
                          decoration: selectedIndex == 0 ? TextDecoration.underline : null,
                          decorationColor: MyColors.secondary, // Altı çizgi rengi
                          decorationThickness: 2,

                          // Altı çizgi kalınlığı
                      ),),
                    ), // Butonlar arasında bir boşluk ekleyin
                    GestureDetector(
                      onTap: (){
                        print("b");
                        setState(() {
                          selectedIndex = 1; // Buton 1'e tıklandığında indeksi güncelle
                        });
                        _pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

                        },
                      child: Text('Satıcı Yorumları',
                        style: TextStyle(
                          decoration: selectedIndex == 1 ? TextDecoration.underline : null,
                          decorationColor: MyColors.secondary, // Altı çizgi rengi
                          decorationThickness: 2, // Altı çizgi kalınlığı
                        ),),
                    ),
                  ],
                ),
              )),
          toolbarHeight: 120,
        ),
        body: PageView(
          controller: _pageController,
          children: const [
            ProductComments(),
            SellerComments(),
          ],
        ),

    );
  }
}



class ProductComments extends StatefulWidget {
  const ProductComments({super.key});

  @override
  State<ProductComments> createState() => _ProductCommentsState();
}
class _ProductCommentsState extends State<ProductComments> {

  List<Comment> comments = [];
  List<Product> products = [];
  late Fetcher commentFetcher;
  late Fetcher productsFetcher;
  bool isLoading = true;
  late String userId = box.read('user')['id'].toString();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      commentFetcher = Fetcher(
          Comment.fromJson, _setComments, () => Api.getCommentByUserId(userId));
      await commentFetcher.fetchData();
      List<Future<void>> fetchProductsFutures = comments.map((rental) async {
        try {
          productsFetcher = Fetcher(Product.fromJson, _setProducts,
                  () => Api.getProductsById(rental.productId, userId));
          await productsFetcher.fetchData();
        } catch (error) {
          print("İstek sırasında bir hata oluştu: $error");
          ScaffoldMessenger.of(context,).showSnackBar(
            SnackBar(
              content: Text("İstek sırasında bir hata oluştu: $error"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }).toList();

      await Future.wait(fetchProductsFutures);
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void _setComments(List<dynamic> data) {
    setState(() {
      comments = data.cast<Comment>();
    });
  }

  void _setProducts(List<dynamic> data) {
    setState(() {
      List<Product> fetchedProducts = data.cast<Product>();
      products.addAll(fetchedProducts); // Add fetched products to the list
    });
  }

  String formatDate(DateTime dateTime) {
    // Tarihi gün/ay/yıl formatına çevir
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String year = dateTime.year.toString();

    return '$day/$month/$year';
  }
  Product? findProductForComment(Comment comment) {
    for (Product product in products) {
      if (product.productId == comment.productId) {
        return product;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading // Show loading indicator while products are loading
        ? const IndicatorProgressBar()
        : SingleChildScrollView(
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 150,
                    mainAxisSpacing: 20),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  final product = findProductForComment(comment);
                  //final product = findProductForRental(rental);
                  DateTime date = DateTime.parse('${comment.createdDate}');
                  final createdDate=formatDate(date);
                  return GestureDetector(
                    onTap:(){
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return MyModal(
                            name: product!.name,
                            productId: comment.productId!,
                            userId: userId,
                            imageUrl1: product.filE_URL_1!,
                            imageUrl2: product.filE_URL_2!,
                            imageUrl3: product.filE_URL_3!,
                            text:comment.commentContent
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.tertiary.withOpacity(0.1),
                        border:
                        Border.all(width: 1, color: MyColors.tertiary),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1, // 3'te 1 genişlik
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.memory(
                                  base64Decode(product!.filE_URL_1!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2, // 3'te 2 genişlik
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${product.brandName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MyFontSizes.fontSize_0(context)),maxLines: 2,
                                      ),
                                      Text(
                                        createdDate,style: TextStyle(fontSize: MyFontSizes.fontSize_0(context)),maxLines: 2,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    product.name,style: TextStyle(fontSize: MyFontSizes.fontSize_0(context)),maxLines: 2,
                                  ),
                                  CreateStar(rate: comment.userRating!.toDouble(),size: 15,),
                                  Text(
                                    "${comment.commentContent}",style: TextStyle(fontSize: MyFontSizes.fontSize_0(context),color: Colors.black54),maxLines: 2,
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                  );
                }),
    );
  }
}




class SellerComments extends StatefulWidget {
  const SellerComments({super.key});

  @override
  State<SellerComments> createState() => _SellerCommentsState();
}
class _SellerCommentsState extends State<SellerComments> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Değerlendirilmiş Satıcı Bulunamadı.",style: TextStyle(fontSize: MyFontSizes.fontSize_0(context)),maxLines: 2,
          ),
        ),
      ],
    );
  }
}

/**
    isLoading // Show loading indicator while products are loading
    ? const IndicatorProgressBar()
    : SingleChildScrollView(
    child: GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 1,
    mainAxisExtent: 100,
    mainAxisSpacing: 20),
    itemCount: comments.length,
    itemBuilder: (context, index) {
    final comment = comments[index];
    final product = products[index];
    //final product = findProductForRental(rental);
    DateTime createdDate =
    DateTime.parse('${comment.createdDate}');
    return Container(
    decoration: BoxDecoration(
    color: MyColors.tertiary.withOpacity(0.1),
    border:
    Border.all(width: 1, color: MyColors.tertiary),
    ),
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    children: [
    Text(
    " ${comment.commentContent}",
    ),
    ],
    ),
    ),
    );
    }),
    ));

 */