import 'package:flutter/material.dart';
import '../../constanst/colors.dart';
import '../../constanst/containerSizes.dart';
import '../../constanst/fontSize.dart';
import '../../pages/auth/validate/validator.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final bool number;
  final String? label;
  final int? maxLines;
  final double? width;

  const CustomInputField({
    Key? key,
    required this.controller,
    this.placeholder = "",
    this.number=false,
    this.label = "",
    this.maxLines = 1,
    this.width=1
  }) : super(key: key);


  String? validate(String? value,String? label) {
    final error = FormValidator.requiredField(value, label!);
    return error;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            label!,
            style: TextStyle(
              fontSize: MyFontSizes.fontSize_0(context),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          Container(
            //color: MyColors.tertiary,
            width: MyContainerSizes.widthSize(context, width),
            //height: MyContainerSizes.heightSize(context, 0.06),
            child: TextFormField(
              keyboardType: number==true ? TextInputType.number: null,
              maxLines: maxLines,
              controller: controller,

              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.tertiary, width:1),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                labelText: placeholder,
                alignLabelWithHint: true,
                isDense: true,
                contentPadding: EdgeInsets.all(8)
              ),
                validator:(value)=> validate(value,label),
            ),
          ),
        ],
      ),
    );
  }
}
