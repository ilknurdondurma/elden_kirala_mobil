import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constanst/colors.dart';
import '../../constanst/containerSizes.dart';
import '../buttons/button.dart';

class HighlightCard extends StatelessWidget {
  final String imagePath;
  final String? text;

  const HighlightCard({
    super.key, required this.imagePath, this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MyContainerSizes.widthSize(context, 0.95),
        height: MyContainerSizes.heightSize(context, 0.2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                image: AssetImage(imagePath), // Arka plan resminin yolu
                fit: BoxFit.cover,
                opacity: 0.5// Resmi container'a sığdırmak için
            ),                  border: Border.all(width: 1, color: MyColors.tertiary),
            gradient: const LinearGradient(colors: [MyColors.primary,Colors.white,Colors.white,],begin: AlignmentDirectional.topStart,end: AlignmentDirectional.bottomEnd)
        ),
        child: Row(
          children: [
            CustomButton(
              onPressed: () {
                print("bastı");
                Get.toNamed('/highlights');
              },
              label: text ?? "Ürünleri İncele ",
              variant: "GreenOutline",
              size: "normal",
            )

          ],
        ),
      ),
    );
  }
}
