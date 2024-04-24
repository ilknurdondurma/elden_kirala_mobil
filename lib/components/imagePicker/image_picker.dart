import 'dart:io';
import 'package:elden_kirala/constanst/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constanst/fontSize.dart';
import '../buttons/button.dart';

class CustomImagePicker extends StatefulWidget {
  final int? imageCount;
  final double? squareSize;
  final Function(List<File?> pickedImages)? onImagesPicked; // Callback function to return selected images

  const CustomImagePicker(
      {
        Key? key,
        this.imageCount=1,
        this.squareSize=100,
        this.onImagesPicked,


      });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  List<File?> pickedImages = List.filled(3, null); // List to store picked images
  List<bool> isPickedList = List.filled(3, false); // List to track whether image is picked or not

  Future<void> pickImage(int index, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        pickedImages[index] = File(image.path);
        isPickedList[index] = true;
      });
      if (widget.onImagesPicked != null) {
        widget.onImagesPicked!(pickedImages);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Görsel Ekle",
          style: TextStyle(
            fontSize: MyFontSizes.fontSize_1(context),
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          textAlign: TextAlign.start,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.imageCount!; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    SizedBox(
                      width: widget.squareSize,
                      height: widget.squareSize,
                      child: Container(
                        child: isPickedList[i]
                            ? Image.file(
                          pickedImages[i]!,
                        )
                            : Container(
                          color: Colors.blueGrey[100],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: MyColors.secondary.withOpacity(0.6)
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Resim Seç"),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        GestureDetector(
                                          child: Text("Kamera"),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            pickImage(i, ImageSource.camera);
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                        ),
                                        GestureDetector(
                                          child: Text("Galeri"),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            pickImage(i, ImageSource.gallery);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child:  Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
