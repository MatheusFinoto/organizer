import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 20,
      width: 1,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black54,
    );
  }
}
