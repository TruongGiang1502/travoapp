import 'package:flutter/material.dart';

class PickOptions extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final String imageUrl;
  const PickOptions({super.key, required this.onPressed, required this.backgroundColor, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.square(100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            backgroundColor: Colors.transparent,
            elevation: 0
          ),
          child: Image.asset(imageUrl),
        ), 
      ),
    );
  }
}