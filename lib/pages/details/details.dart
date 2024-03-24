import 'dart:convert';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:elden_kirala/constanst/colors.dart';
import 'package:elden_kirala/constanst/containerSizes.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../api/api.dart';
import '../../components/buttons/button.dart';
import '../../components/text/text.dart';
import '../../layout/appbar/appbar.dart';
import '../../models/product-model/product-model.dart';
import '../../services/fetcher.dart';

final box = GetStorage();

class Details extends StatefulWidget {
  final int? id;

  const Details({Key? key, this.id}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<Product> product = [];
  late Fetcher productFetcher;
  late CarouselSliderController _carouselSliderController; // Add this line
  int index=0;

  @override
  void initState() {
    super.initState();
    _carouselSliderController = CarouselSliderController();
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


  void goToPrevious() {
    setState(() {
      index = (index - 1).clamp(0, 2);

    });
    _carouselSliderController.previousPage();
  }

  void goToNext() {
    setState(() {
      index = (index + 1).clamp(0, 2);
    });
    _carouselSliderController.nextPage();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarInPage(
          title: product.isNotEmpty ? product.first.name : 'Details'),
      body:  product.isEmpty && productFetcher.isLoading // API'den veri bekleniyor
          ? Center(child: LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF61D4AF),
              rightDotColor: const Color(0xFF673ab7),
              size: 20,
            ),)
          : product.isEmpty // Ürün bulunamadı
          ? Center(child: MyText(text: "Ürün bulunamadı"),)
          :SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
              //resim
                  Container(
                    height: MyContainerSizes.heightSize(context, 0.5),
                    width: MyContainerSizes.widthSize(context, 1),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: MyColors.tertiary),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                            children: [
                              Expanded(
                                child: FractionallySizedBox(
                                      widthFactor: 0.9,
                                        heightFactor: 1.0,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.5, // Set the width to half of the screen width
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Icon(Icons.favorite_border),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: CarouselSlider.builder(
                                                  controller: _carouselSliderController,
                                                  itemCount: 3, // Assuming you always have 3 images
                                                  slideBuilder: (index) {
                                                    List<String> imageUrls = [
                                                      product.first.filE_URL_1!,
                                                      product.first.filE_URL_2!,
                                                      product.first.filE_URL_3!,
                                                    ];
                                                    return Image.memory(
                                                      base64Decode(imageUrls[index]),
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: goToPrevious,
                                                    child: Icon(Icons.arrow_back,color: index<=0  ? Colors.grey : MyColors.primary ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: goToNext,
                                                    child: Icon(Icons.arrow_forward,color:index>=2 ? Colors.grey : MyColors.primary ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),)
                         ],
                    ),
                  ),
              //kategori
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${product.first.categoryName} >> ${product.first.subCategoryName}",
                            style: TextStyle(
                              fontSize: MyFontSizes.fontSize_0(context),
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              //name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.first.name.toString(),
                            style: TextStyle(
                              fontSize: MyFontSizes.fontSize_2(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              //yıldızz
                  Row(
                    children: [
                      _buildRatingStars(product.first.rating!.toDouble()),
                      SizedBox(width: 20,),
                      GestureDetector(
                        child: Text(
                          '${product.first.commentCount} değerlendirme',
                          style: TextStyle(
                            fontSize: MyFontSizes.fontSize_1(context),
                          ),
                        ),
                      )
                    ],
                  ),
              //satıcı
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                       border: Border.all(width: 1, color: MyColors.tertiary),
                    ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 8 , horizontal: 20 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${product.first.userName} ${product.first.userSurname}",
                              style: TextStyle(
                                fontSize: MyFontSizes.fontSize_2(context),
                                color: Colors.black54,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                Text(
                                  "${product.first.userCity}",
                                  style: TextStyle(
                                    fontSize: MyFontSizes.fontSize_2(context),
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),


              //descrition
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.first.description.toString(),
                            style: TextStyle(
                              fontSize: MyFontSizes.fontSize_1(context),
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              //durumuu
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Ürün Durumu : ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Button(
                              label: '${product.first.status}',
                              onPressed: () {  },
                              size: 'xsmall',
                              variant: 'Green',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Min Kiralama : ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Button(
                              label: ' ${product.first.minRentalPeriod}  Ay',
                              onPressed: () {  },
                              size: 'xsmall',
                              variant: 'Green',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Max Kiralama : ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Button(
                              label: '${product.first.maxRentalPeriod}  Ay ',
                              onPressed: () {  },
                              size: 'xsmall',
                              variant: 'Green',
                            ),
                          ],
                        )

                      ],
                    ),
                  )
            
            
            ],
                    ),
                  ),
          ),
        bottomNavigationBar: buildBottomBar(context)

    );
  }

  Container buildBottomBar(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.symmetric(vertical:BorderSide.none,horizontal: BorderSide(width: 1,color: MyColors.tertiary)),
          //color: MyColors.secondary
        ),
        height: MediaQuery.of(context).size.height*0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ürün Fiyatı : ",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(
                    "${product.first.price} TL/ay",
                    style: TextStyle(
                      fontSize: MyFontSizes.fontSize_1(context),
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Button(
                    label: 'Satıcıya Sor',
                    onPressed: () {  },
                    size: 'small',
                    variant: 'PurpleOutline',
                  ),

                ],
              ),
            )
          ],
        ),
      );
  }
}
Widget _buildRatingStars(double rating) {
  // Calculate the number of filled stars
  int filledStars = rating.round();

  // Calculate the number of empty stars
  int emptyStars = 5 - filledStars;

  // List to hold the star icons
  List<Widget> starIcons = [];

  // Add filled stars
  for (int i = 0; i < filledStars; i++) {
    starIcons.add(Icon(Icons.star, color: Colors.yellow,size: 20,));
  }

  // Add empty stars
  for (int i = 0; i < emptyStars; i++) {
    starIcons.add(Icon(Icons.star_border, color: Colors.grey,size: 20,));
  }

  // Return a row containing the star icons
  return Row(children: starIcons);
}