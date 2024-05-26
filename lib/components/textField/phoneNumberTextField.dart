import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberTextField extends StatelessWidget {
   PhoneNumberTextField({
    super.key,
    required this.controller,
    required this.initialCountryCode,
    this.isSelected=true,
  });

  final TextEditingController controller;
  final String initialCountryCode;
  final bool? isSelected;


  @override
  Widget build(BuildContext context) {
    PhoneNumber number = PhoneNumber(isoCode: initialCountryCode);
    return Column(
      children: [
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            useBottomSheetSafeArea: true,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: Colors.black),
          initialValue: number,
          textFieldController: controller,
          formatInput: true,
          keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
          inputBorder: const OutlineInputBorder(),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
          isEnabled: isSelected!,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: isSelected! ? () {
              // Kaydetme işlemi
            } : null,
            child: const Text('KAYDET'),
          ),
        ),
      ],
    );
  }
}