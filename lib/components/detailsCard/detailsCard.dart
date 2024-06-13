import 'dart:convert';

import 'package:elden_kirala/components/commentCard/commentCard.dart';
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
final box = GetStorage();



class DetailCard extends StatefulWidget {
final Product product;
  const DetailCard({super.key, required this.product });
  @override
  State<DetailCard> createState() => _DetailCardState();
}


class _DetailCardState extends State<DetailCard> {

  int index=0;
  final ScrollController _controller = ScrollController();
  bool isSucces =false ;
  late int? isLiked =widget.product.liked ;




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
      print(box.read('user')['id']);
      var userId=box.read('user')['id'];
      print(widget.product.productId);
      var productId=widget.product.productId;

      Map<String, dynamic> jsonData = {
        'userId': userId,
        'productId': productId,
      };

      dio.Response response;
      if (isLiked == 0) {
        response = await Api.addFavorite(jsonData);
      } else {
        response = await Api.deleteFavorite(userId,productId);
      }

      if (response.statusCode == 200) {
            print("İstek başarıyla gönderildi. Yanıt: ${response.data}");
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
            //isLiked==1 ?Get.offAndToNamed('/detail/${widget.product.productId}'):null;

      }
      else if (response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 42 ||
          response.statusCode == 415) {
        print('auth hatası');
        Get.offAllNamed('/login');
      } else {
        print('Eklenirken bir hata oluştu');
      }
    } catch (e) {
      print("İstek sırasında bir hata oluştu: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          controller: _controller,
          child: widget.product.productId == null || widget.product.productId == 0
              ? Center(child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: const Color(0xFF61D4AF),
                  rightDotColor: const Color(0xFF673ab7),
                  size: 20,
                ),)
              :Column(
                  children: [
                    //resim
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
                                          isLiked == 1
                                              ? Icons.favorite
                                              : Icons.favorite_border,
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
                    //kategori
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
                    //name
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
                    //yıldızz
                    Row(
                      children: [
                        CreateStar(rate: widget.product.rating!.toDouble(),),
                        const SizedBox(width: 20,),
                        GestureDetector(
                          child: Text(
                            '${widget.product.commentCount} değerlendirme',
                            style: TextStyle(
                              fontSize: MyFontSizes.fontSize_1(context),
                            ),
                          ),
                          onTap: (){
                            _controller.animateTo(
                              _controller.offset + 800, // Kaydırma miktarı
                              curve: Curves.easeOut, // Animasyon eğrisi
                              duration: const Duration(milliseconds: 500), // Animasyon süresi
                            );
                          },
                        )
                      ],
                    ),
                    //satıcı
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: MyColors.tertiary),
                            borderRadius: const BorderRadius.all(Radius.circular(15))
                        ),
                        child: Padding(
                          padding:  const EdgeInsets.symmetric(vertical: 8 , horizontal: 6 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2 ),
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
                    //descrition
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Açıklamalar : ",
                              style: TextStyle(
                                fontSize: MyFontSizes.fontSize_1(context),
                                fontWeight: FontWeight.bold,
                              ),),
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
                    //durumuu
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Ürün Durumu : ",style:TextStyle(
                                fontSize: MyFontSizes.fontSize_1(context),
                                fontWeight: FontWeight.bold,
                              ),),
                              CustomButton(
                                label: '${widget.product.status}',
                                onPressed: () {  },
                                size: 'xsmall',
                                variant: 'Green',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Min Kiralama : ",
                                style: TextStyle(
                                  fontSize: MyFontSizes.fontSize_1(context),
                                  fontWeight: FontWeight.bold,
                                ),),
                              CustomButton(
                                label: ' ${widget.product.minRentalPeriod}  Ay',
                                onPressed: () {  },
                                size: 'xsmall',
                                variant: 'Green',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                               Text("Max Kiralama : ",
                                 style:TextStyle(
                                   fontSize: MyFontSizes.fontSize_1(context),
                                   fontWeight: FontWeight.bold,
                                 ),),
                              CustomButton(
                                label: '${widget.product.maxRentalPeriod}  Ay ',
                                onPressed: () {  },
                                size: 'xsmall',
                                variant: 'Green',
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                    // yorumlar
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("ÜRÜN DEĞERLENDİRMELERİ",style: TextStyle(fontSize: MyFontSizes.fontSize_2(context)),),
                          const SizedBox(height: 20,),
                          CommentCard(productId: widget.product.productId)
                        ],

                      ),
                    ),







                  ],
                ),
        ),
        bottomNavigationBar: buildBottomBar(context)

    );
  }
















  Container buildBottomBar(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
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
                  const Text("Ürün Fiyatı : ",style: TextStyle(fontWeight: FontWeight.bold),),
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

