import 'package:flutter/material.dart';

import '../../constanst/colors.dart';
import '../../constanst/containerSizes.dart';

class CustomDropdownContainer extends StatelessWidget {
  final String selectedItem;
  final List<dynamic> items;
  final Function(String?) onChanged;

  const CustomDropdownContainer({
    required this.selectedItem,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyContainerSizes.widthSize(context, 0.5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: MyColors.tertiary),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: MyColors.tertiary,
          border: Border.all(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedItem,
            items: items.map((dynamic item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
