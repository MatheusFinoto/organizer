import 'package:flutter/material.dart';

class PopUpMenuItemChild extends StatelessWidget {
  const PopUpMenuItemChild({Key? key, required this.title, required this.image})
      : super(key: key);

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 20,
          width: 20,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
        ),
      ],
    );
  }
}
