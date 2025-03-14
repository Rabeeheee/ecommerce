import 'package:flutter/material.dart';

class SubText extends StatelessWidget {
  const SubText({super.key, required this.subText});

  final String subText;

  @override
  Widget build(BuildContext context) {
    return Text(
      subText,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
