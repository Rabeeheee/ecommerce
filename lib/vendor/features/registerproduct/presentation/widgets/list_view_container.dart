import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ListViewContainer extends StatelessWidget {
  const ListViewContainer({
    super.key,
    required this.containerWidth,
     this.centerWidget,
     this.onTapCenterWidget,
    this.crossIcon = true,
    required this.onPressedCrossIcon,
    this.color = AppPallete.darkgreyColor,
  });
  final bool crossIcon;
  final double containerWidth;
  final Widget? centerWidget;
  final void Function()? onTapCenterWidget;
  final void Function()? onPressedCrossIcon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    // int itemCount = widget.initialItemCount;
    return Stack(
      children: [
        centerWidget != null
            ? Container(
                clipBehavior: Clip.antiAlias,
                width: containerWidth,
                // height: 100,
                margin: const EdgeInsets.all(
                  5,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: onTapCenterWidget,
                  child: Center(child: centerWidget),
                ),
              )
            : const SizedBox(),
        crossIcon
            ? Positioned(
                right: 0,
                top: 0,
                child: CircularButton(
                  color: Colors.red,
                  onPressed: onPressedCrossIcon,
                  circularButtonChild: const SvgIcon(
                    icon: CustomIcons.closeSvg,
                    radius: 10,
                  ),
                  diameter: 25,
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
