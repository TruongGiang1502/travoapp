import 'package:flutter/material.dart';

class ContainerBoxDecor extends StatelessWidget {
  final Widget child;
  const ContainerBoxDecor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1, 1)
          )
        ]
      ),
      child: child,
    );
  }
}