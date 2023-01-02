import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.onTap, required this.iconData});

  final VoidCallback onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: blue500.withOpacity(0.2),
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
