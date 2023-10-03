import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travo_demo/utils/validate.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String labelText;
  final TextInputFormatter inputFormat;
  final int lengthInput;
  final TextInputType keyboardType;
  final Widget? prefix;
  const TextFieldCustom(
      {super.key,
      required this.controller,
      required this.validator,
      required this.labelText,
      required this.inputFormat,
      required this.keyboardType,
      required this.prefix,
      this.lengthInput = 40, });

  @override
  Widget build(BuildContext context) {
    return ContainerBoxDecor(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16),
        child: Center(
          child: TextFormField(
            controller: controller,
            validator: Validator.checkNull,
            style: const TextStyle(fontWeight: FontWeight.bold),
            inputFormatters: [inputFormat, LengthLimitingTextInputFormatter(lengthInput)],
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labelText,
              labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
              prefixIcon: prefix
            ),
          ),
        ),
      ),
    );
  }
}
