import 'package:flutter/material.dart';
import '../../constanst/colors.dart';
import '../../constanst/containerSizes.dart';
import '../../constanst/fontSize.dart';
import '../../pages/auth/validate/validator.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final Function(String?)? validator;
  final String? placeholder;
  final bool number;
  final bool? isBorder;
  final bool? obscureText;
  final Icon? icon;
  final String? label;
  final int? maxLines;
  final double? width;
  final double? height;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.placeholder = "",
    this.number = false,
    this.label = "",
    this.maxLines = 1,
    this.width = 1,
    this.height = 0.1,
    this.isBorder = false,
    this.icon,
    this.onChanged,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;

  String? validate(String? value, String? label) {
    final error = FormValidator.requiredField(value, label!);
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MyContainerSizes.widthSize(context, widget.width),
            child: TextFormField(
              obscureText: widget.obscureText!,
              onChanged: (value) {
                setState(() {
                  if (widget.validator != null) {
                    _errorText = widget.validator!(value);
                  } else {
                    _errorText = validate(value, widget.label);
                  }
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
              keyboardType: widget.number ? TextInputType.number : null,
              maxLines: widget.maxLines,
              controller: widget.controller,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: MyFontSizes.fontSize_0(context)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: widget.isBorder!
                    ? OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.tertiary, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )
                    : null,
                labelText: widget.label,
                alignLabelWithHint: true,
                isDense: true,
                hintText: widget.placeholder,
                hintStyle: TextStyle(fontSize: MyFontSizes.fontSize_0(context)),
                prefixIcon: widget.icon,
              ),
            ),
          ),
          if (_errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _errorText!,
                style: TextStyle(color: Colors.red, fontSize: MyFontSizes.fontSize_0(context)),
              ),
            ),
        ],
      ),
    );
  }
}
