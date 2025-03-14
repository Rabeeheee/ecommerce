import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/prize_data_widget.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/sum.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    // required this.index,
    required this.isHorizontal,
    this.heroTransition = true,
    required this.likeButton,
    required this.product,
    // required this.onTapFavouriteButton,
    // required this.isFavorited,
    this.onTapCard,
    // required this.rating,
    // required this.currentCartedCount,
    // this.onTapCartButton,
    // this.onTapPlusButton,
    // this.onTapMinusButton,
    // required this.cartState,
    required this.shoppingCartWidget,
  });
//first we need to send the product model and also the cart model .
  // final int index;
  final bool isHorizontal;
  final Product? product;
  final Widget likeButton;
  final bool heroTransition;
  // final double rating;
  // final bool isFavorited;
  // final Future<bool?> Function(bool)? onTapFavouriteButton;
  final void Function()? onTapCard;
  // final int currentCartedCount;
  // final void Function()? onTapCartButton;
  // final void Function()? onTapPlusButton;
  // final void Function()? onTapMinusButton;
  // final UpdateProductToCartState cartState;
  final Widget shoppingCartWidget;

  @override
  Widget build(BuildContext context) {
    // int initialCount = totalItems;
    return Container(
      width: 185,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppPallete.appShadowColor,
            blurStyle: BlurStyle.normal,
            blurRadius: 5,
            spreadRadius: -3,
          ),
        ],
      ),
      margin: const EdgeInsets.all(5),
      child: product != null
          ? Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
                ),
              ),
              color: AppPallete.whiteColor,
              child: InkWell(
                onTap: onTapCard,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      //sized box for the image and the cart/favorite button
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            //image
                            Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppPallete.lightgreyColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: heroTransition
                                  ? Hero(
                                      tag: product!.productID,
                                      child: CachedNetworkImage(
                                        imageUrl: product!.displayImageURL,
                                        imageBuilder:
                                            (context, imageProvider) => Image(
                                          image: imageProvider,
                                        ),
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey.shade100,
                                          highlightColor: Colors.grey.shade300,
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            color: Colors.white,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: product!.displayImageURL,
                                      imageBuilder: (context, imageProvider) =>
                                          Image(
                                        image: imageProvider,
                                      ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey.shade100,
                                        highlightColor: Colors.grey.shade300,
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          color: Colors.white,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                            ),

                            //rating
                            Positioned(
                              bottom: 5,
                              left: 5,
                              child: Container(
                                height: 15,
                                width: 70,
                                decoration: const BoxDecoration(
                                  color: AppPallete.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppPallete.appShadowColor,
                                      blurStyle: BlurStyle.normal,
                                      blurRadius: 2,
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      product!.rating.toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SvgIcon(
                                      icon: CustomIcons.starSvg,
                                      radius: 10,
                                      color: Colors.green,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Text(
                                      product!.rating.toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: AppPallete.greyTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(top: 5, right: 5, child: likeButton),
                            //favorite
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: shoppingCartWidget,
                            ),
                          ],
                        ),
                      ),
                      //this is for the whole height of onw of the listview
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //product title
                            Text(
                              product!.name,
                              softWrap: true,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            //product price
                            SizedBox(
                              width: 150,
                              child: PrizeDataWidget(
                                totalHeight: 170,
                                prize: '${product!.prize}',
                                offPercentage:
                                    '${calculateDiscountPercentage(product!.oldPrize, product!.prize)}%',
                                previousPrize: product!.oldPrize.toString(),
                              ),
                            ),
                            Container(
                              height: 8,
                              width: 40,
                              decoration: BoxDecoration(
                                color: product!.quantity == 0
                                    ? Colors.red
                                    : Colors.green,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppPallete.appShadowColor,
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 2,
                                  )
                                ],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade300,
              child: const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      5,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
