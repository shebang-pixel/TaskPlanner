import 'package:flutter/material.dart';

class PriorityBox extends StatelessWidget {
  final Color color;
  const PriorityBox({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
