import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class BottomNavigationBarContainer extends StatelessWidget {
  const BottomNavigationBarContainer({
    super.key,
    required this.children,
  });
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(
        10,
      ),
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
      decoration: const BoxDecoration(
        color: AppPallete.primaryAppButtonColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            24,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppPallete.primaryAppColor,
            blurStyle: BlurStyle.normal,
            blurRadius: 15,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}