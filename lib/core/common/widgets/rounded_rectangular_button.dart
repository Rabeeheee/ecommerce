import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class RoundedRectangularButton extends StatelessWidget {
  const RoundedRectangularButton(
      {super.key,
      required this.title,
      this.onPressed,
      this.outlined = false,
      this.isLoading = false});

  final bool outlined;
  final bool isLoading;

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: outlined
              ? const BorderSide(
                  width: 1.5,
                  color: AppPallete.primaryAppButtonColor,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ).copyWith(
        backgroundColor: WidgetStatePropertyAll(
          outlined ? AppPallete.whiteColor : AppPallete.primaryAppButtonColor,
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              title,
              style: TextStyle(
                  color: outlined
                      ? AppPallete.primaryAppButtonColor
                      : AppPallete.whiteColor),
            ),
    );
  }
}
