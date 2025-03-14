
import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class GlobalPageDivider extends StatelessWidget {
  const GlobalPageDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.darkgreyColor,
      height: 10,
      width: double.infinity,
    );
  }
}
