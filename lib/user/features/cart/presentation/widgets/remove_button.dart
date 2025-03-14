import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class RemoveButton extends StatelessWidget {
  const RemoveButton({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 25,
      child: InkWell(
        onTap: onTap,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgIcon(
              icon: CustomIcons.trashBinSvg,
              radius: 15,
              color: AppPallete.greyTextColor,
              fit: BoxFit.scaleDown,
            ),
            Text(
              'Remove',
              style: TextStyle(
                color: AppPallete.greyTextColor,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
