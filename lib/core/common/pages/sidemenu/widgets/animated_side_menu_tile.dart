
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tech_haven/core/rive/rive_assets.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class AnimatedSideMenuTile extends StatelessWidget {
  const AnimatedSideMenuTile({
    super.key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  });

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 24,
          ),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            isActive
                ? AnimatedPositioned(
                    duration: const Duration(seconds: 5),
                    height: 56,
                    curve: Curves.fastOutSlowIn,
                    width: isActive ? 288 : 0,
                    left: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppPallete.primaryAppButtonColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  )
                : const SizedBox(),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: riveonInit,
                ),
              ),
              title: Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}