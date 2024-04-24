import 'package:elden_kirala/constanst/fontSize.dart';
import 'package:flutter/material.dart';

import '../../constanst/colors.dart';
import '../../constanst/containerSizes.dart';

class CustomDropdownContainer extends StatelessWidget {
  final dynamic? value;
  final String? label;
  final double? width;
  final List<dynamic> items;
  final Function(String?) onChanged;

  const CustomDropdownContainer({
    this.value,
    this.label ="",
    this.width=0.35,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(label!,
            style: TextStyle(
                fontSize: MyFontSizes.fontSize_0(context),
                fontWeight: FontWeight.w500

            ),
            maxLines: 1,
            textAlign: TextAlign.start,),
          Container(
            width: MyContainerSizes.widthSize(context, width),
            height: MyContainerSizes.heightSize(context, 0.05),
            decoration: BoxDecoration(
              border: Border.all(width: 0.05, color: MyColors.tertiary),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: MyColors.secondary.withOpacity(0.8),
                //color: MyColors.tertiary,
                border: Border.all(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  hint: Text("Seçilmedi",style: TextStyle(color: Colors.redAccent,
                      fontSize: MyFontSizes.fontSize_0(context),
                      fontWeight: FontWeight.w400)),
                  isExpanded: true,
                  dropdownColor: MyColors.secondary.withOpacity(0.8),
                  //dropdownColor: MyColors.tertiary,
                  items: items.map((dynamic item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,style: TextStyle(
                        color: Colors.white,
                        fontSize: MyFontSizes.fontSize_0(context),
                            fontWeight: FontWeight.w400
                      ),),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
