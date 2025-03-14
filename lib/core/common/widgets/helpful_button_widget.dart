import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
class HelpfulButtonWidget extends StatefulWidget {
  final int initialCount;
  final bool isInitiallyLiked;
  final Function(bool) onPressed;

  const HelpfulButtonWidget({
    super.key,
    required this.initialCount,
    required this.isInitiallyLiked,
    required this.onPressed,
  });

   @override
  State<HelpfulButtonWidget> createState() => _HelpfulButtonWidgetState();
}

class _HelpfulButtonWidgetState extends State<HelpfulButtonWidget> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isInitiallyLiked;
    likeCount = widget.initialCount;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
    widget.onPressed(isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        toggleLike();
      },
      icon: SvgIcon(
        icon: isLiked ? CustomIcons.thumbUpFilledSvg : CustomIcons.thumbUpSvg,
        radius: 20,
        color: isLiked
            ? AppPallete.primaryAppButtonColor
            : AppPallete.greyTextColor,
      ),
      label: Text(
        '$likeCount',
        style: const TextStyle(
          color: AppPallete.greyTextColor,
        ),
      ),
    );

    //  Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     IconButton(
    //       icon: Icon(
    //         isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
    //         color: isLiked ? Colors.blue : Colors.grey,
    //       ),
    //       onPressed: toggleLike,
    //     ),
    //     const SizedBox(width: 8),
    //     Text(
    //       '$likeCount',
    //       style: const TextStyle(fontSize: 24),
    //     ),
    //   ],
    // );
  }
}
