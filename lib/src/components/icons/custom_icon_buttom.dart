import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.onTap, required this.iconData, this.color});

  final VoidCallback onTap;
  final IconData iconData;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: color ?? blue500.withOpacity(0.2),
          borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Center(
          child: Icon(iconData),
        ),
      ),
    );
  }
}
