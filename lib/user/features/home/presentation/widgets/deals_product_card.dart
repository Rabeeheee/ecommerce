import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class DealsProductCard extends StatelessWidget {
  const DealsProductCard({
    super.key,
    required this.isHorizontal,
    this.heroTransition = true,
    required this.likeButton,
    required this.product,
    this.onTapCard,
    required this.shoppingCartWidget,
  });

  final bool isHorizontal;
  final Product? product;
  final Widget likeButton;
  final bool heroTransition;
  final void Function()? onTapCard;
  final Widget shoppingCartWidget;

  @override
  Widget build(BuildContext context) {
    return product != null
        ? InkWell(
            onTap: onTapCard,
            child: Container(
              // clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppPallete.appShadowColor,
                    blurStyle: BlurStyle.normal,
                    blurRadius: 8,
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Sized box for the image and the cart/favorite button
                  Expanded(
                    child: Stack(
                      children: [
                        // Image
                        CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              color: AppPallete.whiteColor,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:  BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          imageUrl: product!.displayImageURL,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade100,
                            highlightColor: Colors.grey.shade300,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppPallete.whiteColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: const BoxDecoration(
                              color: AppPallete.whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: const Icon(Icons.error),
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 120,
                            height: 15,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: const BoxDecoration(
                              color: AppPallete.primaryAppColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              '${product!.subCategory} Deals',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppPallete.whiteColor,
                                overflow: TextOverflow.ellipsis,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: false,
                            ),
                          ),
                        ),
                        Positioned(top: 5, right: 5, child: likeButton),
                        Positioned(
                            bottom: 5, right: 5, child: shoppingCartWidget),
                      ],
                    ),
                  ),
                  // This is for the whole height of one of the listview
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      color: AppPallete.lightgreyColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product title
                          Text(
                            product!.name,
                            softWrap: true,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Product price
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'AED',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${product!.prize}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      product!.oldPrize.toString(),
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2.0,
                                      ),
                                    ),
                                    const Text(
                                      'AED',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade300,
            child: Column(
              children: [
                // Shimmer for image and the cart/favorite button
                Expanded(
                  child: Stack(
                    children: [
                      // Image shimmer
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      // Smartphone deals shimmer
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 120,
                          height: 15,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(top: 5, right: 5, child: likeButton),
                      Positioned(
                          bottom: 5, right: 5, child: shoppingCartWidget),
                    ],
                  ),
                ),
                // Shimmer for product details
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    color: Colors.grey.shade100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product title shimmer
                        Container(
                          width: double.infinity,
                          height: 15,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 5),
                        // Product price shimmer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              height: 15,
                              color: Colors.grey,
                            ),
                            Container(
                              width: 40,
                              height: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
