import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

ValueNotifier<double> starValueNotifier = ValueNotifier(0);
ValueNotifier<double> starValueNotifierForReviewPage = ValueNotifier(0);

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget(
      {super.key,
      required this.isForReviewPage,
      this.starSpacing = 8,
      this.starSize = 18,
      required this.onValueChanged
      //  required this.valueNotifier
      });
  final bool isForReviewPage;
  final double starSize;
  final double starSpacing;
  final dynamic Function(double)? onValueChanged;
  // final ValueNotifier<double> valueNotifier;

  @override
  Widget build(BuildContext context) {
    isForReviewPage
        ? starValueNotifierForReviewPage.value = starValueNotifier.value
        : null;
    return ValueListenableBuilder(
      valueListenable:
          isForReviewPage ? starValueNotifierForReviewPage : starValueNotifier,
      builder: (context, value, child) {
        return RatingStars(
          starSize: starSize,
          starColor: Colors.green,
          starCount: 5,
          value: value,
          starSpacing: starSpacing,
          animationDuration: const Duration(milliseconds: 750),
          onValueChanged:onValueChanged
        );
      },
      // child:
    );
  }
}
