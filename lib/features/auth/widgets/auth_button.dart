import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String text;
  const AuthButton({super.key, required this.formKey, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 50,
      width: size.width*0.75,
      child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Processing Data')),
              );
            }
          },
          child: Text(text)),
    );
  }
}