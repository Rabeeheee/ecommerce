import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class AuthenticationContainer extends StatelessWidget {
  // final double height;
  final String title;
  final String subTitle;
  final List<Widget> columnChildren;
  // final bool buttonNeeded;
  // final String buttonText;
  // final bool topButtonNeeded;
  // final Widget topButtonChild;
  // final void Function()? onPressedElevatedButton;
  // final void Function()? onPressedTopButton;

  const AuthenticationContainer({
    super.key,
    // required this.height,
    required this.title,
    this.subTitle = '',
    required this.columnChildren,
    // this.buttonNeeded = false,
    // this.buttonText = '',
    // this.topButtonNeeded = false,
    // this.topButtonChild = const Icon(Icons.arrow_forward_rounded),
    // this.onPressedElevatedButton,
    // this.onPressedTopButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints.tight(const Size(500, 1000)),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        boxShadow: const [Constants.globalBoxBlur],
        color: AppPallete.whiteColor,
        borderRadius: Responsive.isMobile(context)
            ? const BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))
            : const BorderRadius.all(Radius.circular(45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeIn(
            duration: const Duration(
              milliseconds: Constants.normalAnimationMilliseconds,
            ),
            curve: Curves.easeIn,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          FadeIn(
            duration: const Duration(
              milliseconds: Constants.normalAnimationMilliseconds,
            ),
            curve: Curves.easeIn,
            child: Text(subTitle),
          ),
          Expanded(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: columnChildren,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
