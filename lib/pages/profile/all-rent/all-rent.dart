import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:elden_kirala/components/buttons/button.dart';
import 'package:elden_kirala/constanst/colors.dart';
import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/material.dart';


import '../../../api/api.dart';
import '../../../components/modal/modal.dart';
import '../../../components/progressIndicator/progressIndicator.dart';
import '../../../components/textField/custom_input_field.dart';
import '../../../constanst/containerSizes.dart';
import '../../../constanst/texts.dart';
import '../../../layout/appbar/appbar.dart';
import '../../../models/product-model/product-model.dart';
import '../../../models/rental-model/rental-model.dart';
import '../../../services/fetcher.dart';

final box = GetStorage();

class AllRent extends StatefulWidget {
  const AllRent({super.key});

  @override
  State<AllRent> createState() => _AllRentState();
}

class _AllRentState extends State<AllRent> {
  final TextEditingController _searchController = TextEditingController();
  late String userId = box.read('user')['id'].toString();
  int selectedButtonIndex = 0;
  List<Rental> rentals = [];
  List<Product> products = [];
  late Fetcher rentalsFetcher;
  late Fetcher productsFetcher;
  bool isLoading = true;
  final List<Map<dynamic, dynamic>> buttonData = [
    {"id": 1, "name": "Tümü"},
    {"id": 2, "name": "Şuan Kirada"},
    {"id": 3, "name": "Teslim Edildi"},
    {"id": 4, "name": "Ödendi"},
    {"id": 5, "name": "Ödenmedi"},
    {"id": 6, "name": "İptaller"},
  ];

  @override
  void initState() {
    super.initState();
    //rentalsFetcher = Fetcher(Rental.fromJson, _setRentals, () => Api.getRentalsByUserId(userId));
    //rentalsFetcher.fetchData();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      rentalsFetcher = Fetcher(Rental.fromJson, _setRentals, () => Api.getRentalsByUserId(userId));
      await rentalsFetcher.fetchData();
      List<Future<void>> fetchProductsFutures = rentals.map((rental) async {
        try {
          productsFetcher = Fetcher(Product.fromJson, _setProducts, () => Api.getProductsById(rental.productId, userId));
          await productsFetcher.fetchData();
        } catch (error) {
          // Handle error
        }
      }).toList();

      await Future.wait(fetchProductsFutures);
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print("İstek sırasında bir hata oluştu: $error");
      ScaffoldMessenger.of(context,).showSnackBar(
        SnackBar(
          content: Text("İstek sırasında bir hata oluştu: $error"),
          duration: Duration(seconds: 2),
        ),
      );
      // Handle error
    }
  }

  Product? findProductForRental(Rental rental) {
    for (Product product in products) {
      if (product.id == rental.productId) {
        return product;
      }
    }
    return null;
  }

  void _setRentals(List<dynamic> data) {
    setState(() {
      rentals = data.cast<Rental>();
    });
  }

  void _setProducts(List<dynamic> data) {
    setState(() {
      List<Product> fetchedProducts = data.cast<Product>();
      products.addAll(fetchedProducts); // Add fetched products to the list
    });
  }

  void filterStatus(int buttonIndex) {
    setState(() {
      selectedButtonIndex = buttonIndex;
    });
  }

  bool _filterMatches(int selectedButtonIndex, Rental rental) {
    switch (selectedButtonIndex) {
      case 0: // Tümü
        return true;
      case 1: // Şuan Kirada
        return rental.rentalStatus == true;
      case 2: // Teslim Edildi
        return rental.rentalStatus == false;
      case 3: // Ödendi
        return rental.paymentStatus == true;
      case 4: // Ödenmedi
        return rental.paymentStatus == false;
      default:
        return true;
    }
  }

  String formatDate(DateTime dateTime) {
    // Tarihi gün/ay/yıl formatına çevir
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String year = dateTime.year.toString();

    return '$day/$month/$year';
  }

  goDetailHandle(productId) {
   Get.toNamed('/detail/$productId');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarInPage(
        title: "Tüm Kiralamalarım",
        showLeadingIcon: false,
      ),
      body: isLoading // Show loading indicator while products are loading
          ? IndicatorProgressBar()
          : SingleChildScrollView(
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          searchButton(context),
                          filterButtons(context),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisExtent: 200,
                                mainAxisSpacing: 20),
                            itemCount: rentals.length,
                            itemBuilder: (context, index) {
                              final rental = rentals[index];
                              //final reversedProducts = products.reversed.toList();
                              //final product = reversedProducts[index];
                              //final product = products[index];
                              final product = findProductForRental(rental);
                              DateTime startDate = DateTime.parse('${rental.startDate}');
                              DateTime endDate = DateTime.parse('${rental.endDate}');
                              if (_filterMatches(selectedButtonIndex, rental)) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: MyColors.tertiary.withOpacity(0.1),
                                    border: Border.all(
                                        width: 1, color: MyColors.tertiary),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        //kira durumu
                                        Row(
                                          children: [
                                            Text(
                                              rental.rentalStatus == true
                                                  ? "Şuan Kirada"
                                                  : "Teslim Edildi",
                                              style: TextStyle(
                                                color: rental.rentalStatus == true
                                                    ? MyColors.secondary
                                                    : MyColors.primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Icon(
                                                rental.rentalStatus == true
                                                    ? Icons.local_shipping_outlined
                                                    : Icons.check,
                                                size: 20,
                                                color: rental.rentalStatus == true
                                                    ? MyColors.secondary
                                                    : MyColors.primary)
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        //tarih
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              formatDate(startDate),
                                              style: TextStyle(
                                                  fontSize: MyFontSizes.fontSize_1(
                                                      context)),
                                            ),
                                            Text("-"),
                                            Text(formatDate(endDate),
                                                style: TextStyle(
                                                    fontSize: MyFontSizes.fontSize_1(
                                                        context))),
                                          ],
                                        ),
                                        //toplam ,ödeme ve detay
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Toplam: ${rental.rentalPrice} TL ",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  " ${rental.paymentStatus == true ? "Ödendi" : "Ödenmedi"}",
                                                  style: TextStyle(
                                                      color:
                                                      rental.paymentStatus == true
                                                          ? MyColors.primary
                                                          : Colors.red,
                                                      fontWeight: FontWeight.bold),
                                                ),

                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap:()=>{
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return MyModal(
                                                          isUpdate: false,
                                                          name: product!.name,
                                                          productId: rental.productId!,
                                                          userId: userId,
                                                          imageUrl1: product.filE_URL_1!,
                                                          imageUrl2: product.filE_URL_2!,
                                                          imageUrl3: product.filE_URL_3!,
                                                        );
                                                      },
                                                    )
                                                  },
                                                  child: Text(
                                                    "Değerlendir",
                                                    style: TextStyle(
                                                        fontSize:
                                                        MyFontSizes.fontSize_1(
                                                            context),
                                                        color: MyColors.primary),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.chevron_right,
                                                  size: 15,
                                                  color: MyColors.primary,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Divider(height: 10),
                                        //isim ve resim
                                        Column(
                                          children: [
                                            Text(
                                              "${product!.name}", // Displaying product name
                                              maxLines: 1,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: ()=>goDetailHandle(product.id),
                                              child: SizedBox(
                                                height: MyContainerSizes.heightSize(
                                                    context, 0.08),
                                                child: product.filE_URL_1!= null
                                                    ? Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Image.memory(
                                                        base64Decode(
                                                            product.filE_URL_1!),
                                                        fit: BoxFit.cover),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Image.memory(
                                                      base64Decode(
                                                          product.filE_URL_2!),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                )
                                                    : Placeholder(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else {
                                // Filtreleme sonucunda ürünü ekrana göstermemiz gerekmiyorsa, boş bir container döndür
                                return Container();
                              }
                            },
                          )
                        ],
                      ),
                    )),
      ),
    );
  }

  Padding filterButtons(BuildContext context) {
    return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                buttonData.length,
                                    (index) => GestureDetector(
                                  onTap: () => filterStatus(index),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: selectedButtonIndex == index
                                          ? MyColors.primary
                                          : MyColors.tertiary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.card_travel,
                                          size: 17,
                                        ),
                                        Text(
                                          buttonData[index]["name"] as String,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                              MyFontSizes.fontSize_0(context)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
  }

  Padding searchButton(BuildContext context) {
    return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            width: MyContainerSizes.widthSize(context, 0.9),
                            child: CustomTextField(
                              controller: _searchController,
                              //onChanged: (keyword) => searchRentals(_searchController.text),
                              placeholder: MyTexts.search,
                              label: "Ürün İsmi veya Marka ara",
                              isBorder: true,
                              icon: const Icon(
                                Icons.search,
                                size: 15,
                              ),
                              width: 1,
                            ),
                          ),
                        );
  }
}

