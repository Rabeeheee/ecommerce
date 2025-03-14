import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ShoppingCartButton extends StatefulWidget {
  const ShoppingCartButton({
    super.key,
    this.onTapMinusButton,
    this.onTapPlusButton,
    required this.currentCount,
    this.isLoading = false,
    this.onTapCartButton,
    // this.isExpanded = false,
  });

  final void Function()? onTapMinusButton;
  final void Function()? onTapPlusButton;
  final void Function()? onTapCartButton;
  final int currentCount;
  final bool isLoading;

  @override
  State<ShoppingCartButton> createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton> {
  // final bool isExpanded;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      width: isExpanded ? 80 : 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        color: isExpanded
            ? AppPallete.primaryAppButtonColor
            : AppPallete.whiteColor,
        boxShadow: const [
          BoxShadow(
            color: AppPallete.appShadowColor,
            blurStyle: BlurStyle.normal,
            blurRadius: 3,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            isExpanded ? 30 : 10.0,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          widget.onTapCartButton;
          setState(() {
            isExpanded = isExpanded ? false : true;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (isExpanded)
              GestureDetector(
                onTap: widget.onTapPlusButton,
                child: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            isExpanded && !widget.isLoading
                ? Text(
                    widget.currentCount.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                : isExpanded && widget.isLoading
                    ? Lottie.asset(
                        'assets/lotties/loading_lottie.json',
                        height: 15,
                        width: 15,
                      )
                    : const SvgIcon(
                        icon: CustomIcons.cartSvg,
                        radius: 20,
                        color: Colors.black,
                      ),
            if (isExpanded)
              GestureDetector(
                onTap: widget.onTapMinusButton,
                child: const Text(
                  '-',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
