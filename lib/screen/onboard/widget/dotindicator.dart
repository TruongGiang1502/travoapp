import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final bool active;
  const DotIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: active ? 20: 8,
      decoration: BoxDecoration(
        color: active ? Colors.orange : Colors.grey,
        borderRadius: BorderRadius.circular(12)
      ),
    );
  }
}