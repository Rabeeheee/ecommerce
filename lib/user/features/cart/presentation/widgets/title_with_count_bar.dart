import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class TitleWithCountBar extends StatelessWidget {
  const TitleWithCountBar(
      {super.key,
      required this.title,
      required this.itemsCount,
      this.isForFavorite = false,
      this.totalPrize = '0'});

  final String title;
  final String itemsCount;
  final bool isForFavorite;
  final String totalPrize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                itemsCount,
                style: const TextStyle(
                  color: AppPallete.greyTextColor,
                ),
              ),
            ],
          ),
          if (!isForFavorite)
            Text(
              totalPrize,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            )
        ],
      ),
    );
  }
}
