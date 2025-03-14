
import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ProductBrandAndTitle extends StatelessWidget {
  const ProductBrandAndTitle({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    // CarouselSlider
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalTitleText(
            title: product.brandName,
            fontSize: 16,
            color: AppPallete.primaryAppColor,
          ),
          Constants.kHeight,
          Text(
            product.name,
          ),
        ],
      ),
    );
  }
}
