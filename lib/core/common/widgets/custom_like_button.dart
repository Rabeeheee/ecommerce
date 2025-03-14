import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/square_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({
    super.key,
    required this.isFavorited,
    required this.onTapFavouriteButton,
  });

  final bool isFavorited;
  final Future<bool?> Function(bool p1)? onTapFavouriteButton;

  @override
  Widget build(BuildContext context) {
    return SquareButton(
      // side: 45,
      icon: LikeButton(
        isLiked: isFavorited,
        mainAxisAlignment: MainAxisAlignment.end,
        animationDuration: const Duration(
          milliseconds: 500,
        ),
        onTap: onTapFavouriteButton,
        size: 20,
        likeBuilder: (isLiked) {
          // Functiony hello = () {};
          return SvgIcon(
            icon: isLiked
                ? CustomIcons.heartFilledSvg
                : CustomIcons.heartSvg,
            color: isLiked
                ? Colors.red
                : AppPallete.greyTextColor,
            radius: 5,
            fit: BoxFit.scaleDown,
          );
        },
      ),
    );
  }
}
