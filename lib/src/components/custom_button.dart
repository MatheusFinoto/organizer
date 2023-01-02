import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.color,
      this.height,
      this.fontSize,
      this.textColor});

  final VoidCallback? onPressed;
  final String title;
  final double? fontSize;
  final double? height;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 40,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? Theme.of(context).primaryColor,
              textStyle: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize ?? 16,
                  fontWeight: FontWeight.bold),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                color: textColor ?? Colors.white,
              ),
            )));
  }
}
