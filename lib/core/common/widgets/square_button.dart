import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    super.key,
    required this.icon,
    this.side = 33,
  });

  final Widget icon;
  final double side;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: side,
        width: side,
        decoration: const BoxDecoration(
          // color: AppPallete.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppPallete.appShadowColor,
              blurStyle: BlurStyle.normal,
              blurRadius: 2,
              spreadRadius: -3,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(
              5,
            ),
          ),
        ),
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                5,
              ),
            ),
          ),
          child: InkWell(onTap: () {}, child: icon),
        ));
  }
}
