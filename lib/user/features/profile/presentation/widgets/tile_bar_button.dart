import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class TileBarButton extends StatelessWidget {
  const TileBarButton({
    super.key,
    required this.title,
    required this.icon,
    this.subtitle,
    this.color = AppPallete.primaryAppButtonColor,
    this.trailing,
    this.onTap
  });
  final String title;
  final String icon;
  final String? subtitle;
  final Color color;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      onTap: onTap,
      leading: SvgIcon(
        icon: icon,
        radius: 20,
        color: color,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 10,
              ),
            )
          : null,
      trailing: trailing != null
          ? Row(
              children: [
                trailing!,
                const SvgIcon(
                  icon: CustomIcons.angleRightSvg,
                  radius: 15,
                ),
              ],
            )
          : const SvgIcon(
              icon: CustomIcons.angleRightSvg,
              radius: 15,
            ),
    );
  }
}
