import 'package:flutter/material.dart';
import '../../constanst/colors.dart';
import '../../constanst/containerSizes.dart';
import '../../constanst/fontSize.dart';
import '../../pages/auth/validate/validator.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final String? placeholder;
  final bool number;
  final bool? isBorder;
  final Icon? icon;
  final String? label;
  final int? maxLines;
  final double? width;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.placeholder = "",
    this.number=false,
    this.label = "",
    this.maxLines = 1,
    this.width=1,
    this.isBorder=false,
    this.icon,
    this.onChanged,
  }) : super(key: key);


  String? validate(String? value,String? label) {
    final error = FormValidator.requiredField(value, label!);
    return error;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          SizedBox(
            width: MyContainerSizes.widthSize(context, width),
            child: TextFormField(
              onChanged: onChanged,
              keyboardType: number==true ? TextInputType.number: null,
              maxLines: maxLines,
              controller: controller,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: MyFontSizes.fontSize_0(context)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border:  isBorder! ? OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.tertiary, width:0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ) : null,

                labelText: label,
                alignLabelWithHint: true,
                isDense: true,
                hintText: placeholder,
                hintStyle:TextStyle(fontSize: MyFontSizes.fontSize_0(context)),
                prefixIcon:icon,
              ),
                validator:(value)=> validate(value,label),
            ),
          ),
        ],
      ),
    );
  }
}
