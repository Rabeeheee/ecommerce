import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    super.key,
    required this.icon,
    required this.radius,
    this.color = AppPallete.blackColor,
    this.fit = BoxFit.none
  });
  final String icon;
  final double radius;
  final Color color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: radius,
      width: radius,
      theme: SvgTheme(
        currentColor: color,
      ),
      fit: fit,
      // fit: BoxFit.scaleDown,
    );
  }
}
