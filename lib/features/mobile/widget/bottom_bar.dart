import 'package:flutter/material.dart';
import 'package:travo_demo/utils/color.dart';

class BottomBar extends StatelessWidget {
  final String text;
  final int curPageNumber;
  final int widgetNumber;
  final IconData icon; 
  const BottomBar({super.key, required this.curPageNumber, required this.widgetNumber, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: curPageNumber == widgetNumber ?100:30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: curPageNumber == widgetNumber ?navigationBarColor2:Colors.transparent
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon, 
            color: curPageNumber == widgetNumber ?navigationBarColor:navigationBarColor2,
            size: 28,
          ),
          const SizedBox(width: 2,),
          Text(
            curPageNumber == widgetNumber ?text:'', 
            style: TextStyle(
              fontSize: 16,
              color: curPageNumber == widgetNumber ?navigationBarColor:navigationBarColor2
            ),
          ),
        ],
      ),
    );
  }
}