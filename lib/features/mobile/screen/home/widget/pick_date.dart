import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickDate extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconUrl;
  final String text;
  final Widget dateValueWidget;
  const PickDate(
      {super.key,
      required this.onPressed,
      required this.iconUrl,
      required this.text,
      required this.dateValueWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(1, 1))
          ]),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconUrl),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
                dateValueWidget
              ],
            ),
          ],
        ),
      ),
    );
  }
}
