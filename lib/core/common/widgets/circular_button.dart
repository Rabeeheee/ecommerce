import 'package:flutter/material.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.onPressed,
    required this.circularButtonChild,
    required this.diameter,
    this.shadow = true,
    this.color = AppPallete.primaryAppButtonColor,
  });

  final void Function()? onPressed;
  final Widget circularButtonChild;
  final double diameter;
  final bool shadow;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: shadow
            ? [
                Constants.globalBoxBlur,
              ]
            : null,
      ),
      child: IconButton(
        color: color,
        style: const ButtonStyle().copyWith(
            shape: const WidgetStatePropertyAll(
              CircleBorder(),
            ),
            backgroundColor: WidgetStatePropertyAll(
              color,
            )),
        onPressed: onPressed,
        icon: circularButtonChild,
      ),
    );
  }
}
