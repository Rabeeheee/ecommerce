import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class SmallLongButton extends StatelessWidget {
  const SmallLongButton({
    super.key,
    required this.bgColor,
    required this.text,
    required this.onPressed,
  });

  final Color bgColor;
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 25,
      child: ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle().copyWith(
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
                ),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
              bgColor,
            )),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppPallete.whiteColor,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
