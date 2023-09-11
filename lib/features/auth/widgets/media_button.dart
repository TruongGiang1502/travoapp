import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MediaLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final String iconUrl;
  final String text;
  final Color textColor;
  const MediaLoginButton(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.iconUrl,
      required this.text,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: size.width*0.4,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: GestureDetector(
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconUrl,
                  width: 30,
                  height: 30,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    color: textColor
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
