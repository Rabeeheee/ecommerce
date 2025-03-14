import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class GlobalTitleText extends StatelessWidget {
  const GlobalTitleText({
    super.key,
    required this.title,
    this.fontSize = 18,
    this.color = AppPallete.blackColor,
  });
  final String title;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color
      ),
    );
  }
}
