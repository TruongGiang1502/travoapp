import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final bool active;
  const DotIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: active ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: Colors.purple[900],
        borderRadius: BorderRadius.circular(12)
      ),
    );
  }
}