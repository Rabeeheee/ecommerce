import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      onPressed: () {
        GoRouter.of(context).pop();
      },
      circularButtonChild: const SvgIcon(
        icon: CustomIcons.arrowLeftSvg,
        radius: 25,
        // color: AppPallete.whiteColor,
      ),
      diameter: 40,
      color: AppPallete.whiteColor,
      shadow: false,
    );
  }
}
