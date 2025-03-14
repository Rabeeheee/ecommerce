import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class TabText extends StatelessWidget {
  final String title;
  const TabText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppPallete.blackColor,
      ),
    );
  }
}