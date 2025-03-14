import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CustomBlurButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool up;

  const CustomBlurButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.up = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              // Color.fromARGB(186, 147, 147, 147),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppPallete.primaryAppButtonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SvgIcon(
              icon: up ? CustomIcons.angleUpSvg : CustomIcons.chevronDownSvg,
              radius: 15,
            )
          ],
        ),
      ),
    );
  }
}
