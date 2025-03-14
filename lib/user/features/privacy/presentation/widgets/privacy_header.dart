
import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class PrivacyHeader extends StatelessWidget {
  const PrivacyHeader({
    super.key,
    required this.header,
    required this.fontSize,
  });
  final String header;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: AppPallete.primaryAppColor,
      ),
    );
  }
}
