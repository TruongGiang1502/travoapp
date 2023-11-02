import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String labelText;
  final TextInputFormatter inputFormat;
  final bool readOnly;
  final int lengthInput;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final String prefixText;
  final Widget suffix;
  const TextFieldCustom(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.validator,
      this.obscureText = false,
      required this.labelText,
      required this.inputFormat,
      this.readOnly = false,
      required this.keyboardType,
      this.prefixText = '',
      this.prefixIcon,
      this.lengthInput = 40, 
      this.suffix = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return ContainerBoxDecor(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16),
        child: Center(
          child: TextFormField(
            controller: controller,
            validator: validator,
            style: const TextStyle(fontWeight: FontWeight.bold),
            inputFormatters: [inputFormat, LengthLimitingTextInputFormatter(lengthInput)],
            obscureText: obscureText,
            keyboardType: keyboardType,
            readOnly: readOnly,
            decoration: InputDecoration(
              prefixText: prefixText,
              border: InputBorder.none,
              labelText: labelText,
              labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
              suffix: suffix,
              prefixIcon: prefixIcon
            ),
          ),
        ),
      ),
    );
  }
}
