import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Tarih biçimlendirme için gerekli paket

import '../../api/api.dart';
import '../../constanst/containerSizes.dart';
import '../textField/custom_input_field.dart';

class MyModal extends StatefulWidget {
  final bool isUpdate;
  final int? id;
  final String? name;
  final int productId;
  final String userId;
  final String? imageUrl1;
  final String? imageUrl2;
  final String? imageUrl3;
  final String? text;

  MyModal(
      {
      required this.isUpdate,
      this.id,
      this.name,
      this.imageUrl1,
      this.imageUrl2,
      this.imageUrl3,
      required this.productId,
      required this.userId,
      this.text});

  @override
  State<MyModal> createState() => _MyModalState();
}

class _MyModalState extends State<MyModal> {
  late TextEditingController commentController;
  String formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now().toUtc());


  @override
  void initState() {
    super.initState();
    commentController = TextEditingController(text: widget.text ?? "");
  }

  Future<void> handleSubmit() async {
    print(commentController.text + "bastııııııııııııııı");
    try {
      Map<String, dynamic> updatedComment = {
        "id":widget.id,
        "userId": widget.userId,
        "productId": widget.productId,
        "commentContent": commentController.text,
        "createdDate":formattedDate
      };

      Map<String, dynamic> addedComment = {
        "userId": widget.userId,
        "productId": widget.productId,
        "commentContent": commentController.text,
      };

      dio.Response response = await( widget.isUpdate ? Api.updateComment(updatedComment) : Api.addComment(addedComment));
      if (response.statusCode == 200) {
        print("İstek başarıyla gönderildi. Yanıt: ${response.data}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text("Yorum başarılı"),
            duration: Duration(seconds: 2),
          ),
        );
        Map<String, dynamic> responseData = response.data['data'];
        await box.write('user', responseData);
        print(box.read('user'));
        Get.reload();
      }
    } catch (e) {
      print("İstek sırasında bir hata oluştu: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text("İstek sırasında bir hata oluştu"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: MyContainerSizes.heightSize(context, 0.05),
                  width: MyContainerSizes.heightSize(context, 0.08),
                  child: Image.memory(
                    base64Decode(widget.imageUrl1 ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MyContainerSizes.heightSize(context, 0.05),
                  width: MyContainerSizes.heightSize(context, 0.08),
                  child: Image.memory(
                    base64Decode(widget.imageUrl2!),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MyContainerSizes.heightSize(context, 0.05),
                  width: MyContainerSizes.heightSize(context, 0.08),
                  child: Image.memory(
                    base64Decode(widget.imageUrl3!),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(widget.name ?? ""),
              ),
            ),
            CustomTextField(
              controller: commentController,
              isBorder: true,
              maxLines: 10,
              label: "Ürün Değerlendirmeniz ..",
            ),
            ElevatedButton(
              onPressed: () async => {
                await handleSubmit(),
                Navigator.of(context).pop(),
              },
              child: Text("Değerlendir"),
            )
          ],
        ),
      ),
    );
  }
}
