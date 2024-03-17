import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../constanst/colors.dart';
import '../../constanst/containerSizes.dart';
import '../../constanst/fontSize.dart';
import '../../models/product-model/product-model.dart';

class ProductContainer extends StatelessWidget {
  final Product product;

  const ProductContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyContainerSizes.heightSize(context, 0.35),
      width: MyContainerSizes.widthSize(context, 0.30),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: MyColors.tertiary),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Image.memory(
                  base64Decode(product.filE_URL_1.toString().split(',').last),
                  fit: BoxFit.cover,
                ),
              ),
              Text(product.name.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: MyFontSizes.fontSize_1(context)),
                maxLines: 1,
                textAlign: TextAlign.center,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(product.price.toString(),
                    style: TextStyle(
                        color: MyColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: MyFontSizes.fontSize_0(context)),
                    maxLines: 1,
                    textAlign: TextAlign.center,),
                  Text(" TL / MONTH",style: TextStyle(
                      color: MyColors.secondary
                  ),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
