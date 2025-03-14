import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.isActive,
    required this.onTap,
    required this.title,
    this.color = AppPallete.whiteColor,
    required this.icon,
  });
  final Color color;
  final bool isActive;
  final String icon;
  final void Function()? onTap;
  final String title;
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
              onTap: onTap,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: SvgIcon(
                  icon: icon,
                  radius: 20,
                  color: color,
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
