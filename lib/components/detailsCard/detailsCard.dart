import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

import '../../api/api.dart';
import '../../constanst/colors.dart';
import '../../constanst/containerSizes.dart';
import '../../constanst/fontSize.dart';
import '../../models/product-model/product-model.dart';
import '../buttons/button.dart';
import '../stars/stars.dart';
import '../commentCard/commentCard.dart';

final box = GetStorage();

class DetailCard extends StatefulWidget {
  final Product product;
  const DetailCard({super.key, required this.product});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  int index = 0;
  final ScrollController _controller = ScrollController();
  bool isSucces = false;
  late String userId = box.read('user')['id'].toString();
  late int? isLiked = widget.product.liked;
  int rentalTime = 1; // Default rental time

  @override
  void initState() {
    super.initState();
  }

  void goToPrevious() {
    setState(() {
      index = (index - 1).clamp(0, 2);
    });
  }

  void goToNext() {
    setState(() {
      index = (index + 1) % 3; // Modulo operation to cycle through images
    });
  }

  Future<void> handleFavorite() async {
    try {
      var userId = box.read('user')['id'];
      var productId = widget.product.id;

      Map<String, dynamic> jsonData = {
        'userId': userId,
        'productId': productId
      };

      dio.Response response;
      if (isLiked == 0) {
        response = await Api.addFavorite(jsonData);
      } else {
        response = await Api.deleteFavorite(userId, productId);
      }

      if (response.statusCode == 200) {
        setState(() {
          isSucces = true;
          isLiked = isLiked == 1 ? 0 : 1; // Toggle isLiked state
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('İşlem başarıyla gerçekleştirildi.'),
            duration: Duration(seconds: 2),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
      } else if (response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 402 ||
          response.statusCode == 415) {
        Get.offAllNamed('/login');
      } else {
        print('Eklenirken bir hata oluştu');
      }
    } catch (e) {
      print("İstek sırasında bir hata oluştu: $e");
    }
  }

  void handleRentalSelection(int selectedTime) {
    setState(() {
      rentalTime = selectedTime;
    });
    handleRental(widget.product);
  }

  Future<void> handleRental(Product product) async {
    var rentalData = {
      "rentalStatus": true,
      "productId": product.id,
      "receiverUserId": userId,
      "salesUserId": product.userId,
      "startDate": DateTime.now().toIso8601String(),
      "endDate": DateTime.now().add(Duration(days: rentalTime * 30)).toIso8601String(),
      "rentalPrice": rentalTime * product.price!.toInt(),
      "rentalPeriod": rentalTime,
      "paymentStatus": false
    };

    try {
      dio.Response response = await Api.addRental(rentalData); // Ensure this method exists in your Api class

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kiralama başarılı.'),
            duration: Duration(seconds: 2),
          ),

        );
        Get.toNamed('/all-rent');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kiralama sırasında bir hata oluştu: ${response.statusMessage}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print("İstek sırasında bir hata oluştu: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("İstek sırasında bir hata oluştu"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: widget.product.id == null
            ? Center(
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: const Color(0xFF61D4AF),
            rightDotColor: const Color(0xFF673ab7),
            size: 20,
          ),
        )
            : Column(
          children: [
            // Product images and favorite button
            Container(
              height: MyContainerSizes.heightSize(context, 0.6),
              width: MyContainerSizes.widthSize(context, 1),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: MyColors.tertiary),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: handleFavorite,
                                child: Icon(
                                  isLiked == 1 ? Icons.favorite : Icons.favorite_border,
                                  color: isLiked == 1 ? Colors.red : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Image.memory(
                            base64Decode([
                              widget.product.filE_URL_1!,
                              widget.product.filE_URL_2!,
                              widget.product.filE_URL_3!,
                            ][index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: goToPrevious,
                                child: Icon(Icons.arrow_back,
                                    color: index <= 0 ? Colors.grey : MyColors.primary),
                              ),
                              GestureDetector(
                                onTap: goToNext,
                                child: Icon(Icons.arrow_forward,
                                    color: index >= 2 ? Colors.grey : MyColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Product details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${widget.product.categoryName} >> ${widget.product.subCategoryName}",
                      style: TextStyle(
                        fontSize: MyFontSizes.fontSize_0(context),
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.product.name.toString(),
                      style: TextStyle(
                        fontSize: MyFontSizes.fontSize_2(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                CreateStar(rate: widget.product.rating!.toDouble()),
                const SizedBox(width: 20),
                GestureDetector(
                  child: Text(
                    '${widget.product.commentCount} değerlendirme',
                    style: TextStyle(
                      fontSize: MyFontSizes.fontSize_1(context),
                    ),
                  ),
                  onTap: () {
                    _controller.animateTo(
                      _controller.offset + 800,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyColors.tertiary),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/profile_image.jpg'),
                            ),
                          ),
                          Text(
                            "${widget.product.userName} ${widget.product.userSurname}",
                            style: TextStyle(
                              fontSize: MyFontSizes.fontSize_1(context),
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          Text(
                            "${widget.product.userCity}",
                            style: TextStyle(
                              fontSize: MyFontSizes.fontSize_1(context),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Açıklamalar : ",
                        style: TextStyle(
                          fontSize: MyFontSizes.fontSize_1(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.description.toString(),
                          style: TextStyle(
                            fontSize: MyFontSizes.fontSize_1(context),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Ürün Durumu : ",
                        style: TextStyle(
                          fontSize: MyFontSizes.fontSize_1(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomButton(
                        label: '${widget.product.status}',
                        onPressed: () {},
                        size: 'xsmall',
                        variant: 'Green',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Min Kiralama : ",
                        style: TextStyle(
                          fontSize: MyFontSizes.fontSize_1(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomButton(
                        label: ' ${widget.product.minRentalPeriod}  Ay',
                        onPressed: () {},
                        size: 'xsmall',
                        variant: 'Green',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Max Kiralama : ",
                        style: TextStyle(
                          fontSize: MyFontSizes.fontSize_1(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomButton(
                        label: '${widget.product.maxRentalPeriod}  Ay ',
                        onPressed: () {},
                        size: 'xsmall',
                        variant: 'Green',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "ÜRÜN DEĞERLENDİRMELERİ",
                    style: TextStyle(fontSize: MyFontSizes.fontSize_2(context)),
                  ),
                  const SizedBox(height: 20),
                  CommentCard(productId: widget.product.id)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(context, widget.product, userId),
    );
  }

  Container buildBottomBar(BuildContext context, Product product, String userId) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
            vertical: BorderSide.none, horizontal: BorderSide(width: 1, color: MyColors.tertiary)),
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Ürün Fiyatı : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.product.price} TL/ay",
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
                CustomButton(
                  label: 'Satıcıya Sor',
                  onPressed: () {
                    Get.toNamed("/chat/${widget.product.userId}");
                  },
                  size: 'small',
                  variant: 'PurpleOutline',
                ),
                CustomButton(
                  label: 'Kirala',
                  onPressed: () => showRentalOptions(),
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

  void showRentalOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(buttonData.length, (index) {
              final button = buttonData[index];
              return ElevatedButton(
                onPressed: button['disabled'] || widget.product.isActive==false
                    ? null
                    : () => {handleRentalSelection(button['value']) , print(button['value'])},
                child: Text(button['label']),
              );
            }),
          ),
        );
      },
    );
  }

  final List<Map<String, dynamic>> buttonData = [
    {"id": 1, "value": 1, "label": '1 Ay', "disabled": false},
    {"id": 2, "value": 3, "label": '3 Ay', "disabled": false},
    {"id": 3, "value": 6, "label": '6 Ay', "disabled": false},
    {"id": 4, "value": 12, "label": '12 Ay', "disabled": false},
    {"id": 5, "value": 15, "label": '15 Ay', "disabled": false},
    {"id": 6, "value": 18, "label": '18 Ay', "disabled": false},
  ];

  void updateButtonData() {
    buttonData.forEach((button) {
      button['disabled'] = (widget.product.minRentalPeriod! > button['value'] ||
          widget.product.maxRentalPeriod! < button['value'] ||
          widget.product.isActive==false);
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateButtonData();
  }
}
