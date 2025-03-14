import 'package:flutter/material.dart';

class PrizeDataWidget extends StatelessWidget {
  const PrizeDataWidget({
    super.key,
    required this.totalHeight,
    required this.prize,
    required this.offPercentage,
    required this.previousPrize,
  });

  final double totalHeight;
  final String prize;
  final String offPercentage;
  final String previousPrize;

  @override
  Widget build(BuildContext context) {
    final double ratio = totalHeight / 200;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              'AED',
              style: TextStyle(
                fontSize: 12 * ratio,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              prize,
              style: TextStyle(
                fontSize: 18 * ratio,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8), // Adjust spacing between columns
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                previousPrize,
                style: TextStyle(
                  fontSize: 12 * ratio,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 2.0,
                ),
              ),
              const SizedBox(width: 2),
              Flexible(
                child: Text(
                  offPercentage,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12 * ratio,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
