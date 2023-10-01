import 'package:flutter/material.dart';

class TextNameCheckOutPageView extends StatelessWidget {
  final String text;
  final int curPageNumber;
  final int thisPageNumber;

  const TextNameCheckOutPageView(
      {super.key,
      required this.text,
      required this.curPageNumber,
      required this.thisPageNumber});

  @override
  Widget build(BuildContext context) {
    final bool isActive = curPageNumber == thisPageNumber;
    return Row(
      children: [
        Container(
          width: 20,
          decoration: BoxDecoration(
            color: isActive? Colors.white: Colors.grey,
            shape: BoxShape.circle,
        
          ),
          child: Center(
            child: Text(
              '${thisPageNumber+1}',
              style: TextStyle(
                color: isActive?Colors.purple:Colors.white
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            color: isActive?Colors.white:Colors.grey
          ),
        ),
      ],
    );
  }
}
