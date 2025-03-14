import 'package:flutter/material.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class PrimaryAppButton extends StatelessWidget {
  final void Function()? onPressed;
  const PrimaryAppButton({
    super.key,
    required this.buttonText,
    this.onPressed,
  });

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppPallete.bordergreyColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(45),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: Constants.buttonTextFontSize,
          ),
        ),
      ),
    );
  }
}
