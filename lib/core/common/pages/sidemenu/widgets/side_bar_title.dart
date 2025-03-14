
import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class SideBarTitle extends StatelessWidget {
  const SideBarTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
      child: Text(title.toUpperCase(),
          style: const TextStyle(
            color: AppPallete.whiteColor,
          )),
    );
  }
}
