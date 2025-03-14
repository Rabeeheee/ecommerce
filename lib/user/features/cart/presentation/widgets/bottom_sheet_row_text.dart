
import 'package:flutter/material.dart';

class BottomSheetRowText extends StatelessWidget {
  const BottomSheetRowText({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}

//if there is carted product in list of products then it will return true on the index of the product that means that the current product is carted

//then if that product is carted then it will return true at that index ....
