import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/remove_button.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/save_button.dart';

import '../../constants/constants.dart';

class RectangularProductCard extends StatelessWidget {
  const RectangularProductCard(
      {super.key,
      // required this.items,

      this.isLoading = false,
      required this.onTap,
      required this.isFavoriteCard,
      required this.productName,
      required this.textEditingController,
      required this.productPrize,
      required this.vendorName,
      required this.deliveryDate,
      this.onTapFavouriteButton,
      required this.productImage,
      this.isFavorite = false,
      this.onPressedSaveButton,
      this.productQuantity = '0',
      this.onTapRemoveButton});
  final bool isFavoriteCard;
  final bool isFavorite;
  final bool isLoading;
  final TextEditingController? textEditingController;
  final void Function()? onTap;
  final String productName;
  final String productPrize;
  final String productQuantity;
  final void Function()? onTapRemoveButton;
  final String vendorName;
  final void Function()? onPressedSaveButton;
  final String deliveryDate;
  final String? productImage;
  final Future<bool?> Function(bool)? onTapFavouriteButton;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade300,
            child: RectangularProductCardContent(
              onTapRemoveButton: onTapRemoveButton,
              onTap: onTap,
              productName: productName,
              productPrize: productPrize,
              isFavoriteCard: isFavoriteCard,
              deliveryDate: deliveryDate,
              vendorName: vendorName,
              productImage: productImage,
              onTapFavouriteButton: onTapFavouriteButton,
              isFavorited: isFavorite,
              textEditingController: textEditingController,
              onPressedSaveButton: onPressedSaveButton,
              productQuantity: productQuantity,
            ),
          )
        : RectangularProductCardContent(
            onTap: onTap,
            onTapRemoveButton: onTapRemoveButton,
            productName: productName,
            productPrize: productPrize,
            isFavoriteCard: isFavoriteCard,
            deliveryDate: deliveryDate,
            vendorName: vendorName,
            productImage: productImage,
            onTapFavouriteButton: onTapFavouriteButton,
            onPressedSaveButton: onPressedSaveButton,
            isFavorited: isFavorite,
            textEditingController: textEditingController,
            productQuantity: productQuantity,
          );
  }
}

class RectangularProductCardContent extends StatelessWidget {
  const RectangularProductCardContent({
    super.key,
    required this.onTap,
    required this.productName,
    required this.productPrize,
    required this.isFavoriteCard,
    required this.deliveryDate,
    required this.vendorName,
    required this.textEditingController,
    required this.productImage,
    required this.onTapFavouriteButton,
    required this.isFavorited,
    this.onPressedSaveButton,
    required this.productQuantity,
    this.onTapRemoveButton,
  });

  final void Function()? onTap;
  final String productName;
  final String productQuantity;
  final String productPrize;
  final bool isFavoriteCard;
  final String deliveryDate;
  final void Function()? onPressedSaveButton;
  final TextEditingController? textEditingController;
  final String vendorName;
  final void Function()? onTapRemoveButton;
  final String? productImage;
  final Future<bool?> Function(bool boolean)? onTapFavouriteButton;
  final bool isFavorited;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //for the heading
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Constants.kHeight,
                      //for the price
                      Row(
                        children: [
                          const Text(
                            'AED',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            productPrize,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Constants.kHeight,
                      //for the delivery
                      if (!isFavoriteCard)
                        Row(
                          children: [
                            const Text(
                              'Free Delivery by',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              deliveryDate,
                              style: const TextStyle(
                                color: AppPallete.primaryAppButtonColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      Constants.kHeight,
                      //for the vendor name
                      Row(
                        children: [
                          const Text('Sold by'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            vendorName,
                            style: const TextStyle(
                              // color: AppPallete.primaryAppButtonColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: productImage != null
                        ? CachedNetworkImage(
                            imageUrl: productImage!,
                            placeholder: (context, url) => Image.asset(
                              'assets/logo/techHavenLogo.png',
                              fit: BoxFit.contain,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/logo/techHavenLogo.png',
                              fit: BoxFit.contain,
                            ),
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            'assets/logo/techHavenLogo.png',
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ],
            ),
            Constants.kHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isFavoriteCard)
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 70,
                            child: TextFormField(
                              controller: textEditingController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: 'Quantity',
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                ),
                                alignLabelWithHint: true,
                                contentPadding: EdgeInsets.only(bottom: 2),
                                fillColor: AppPallete.darkgreyColor,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: SaveButton(
                              onPressed: onPressedSaveButton,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Total Quantity Available : $productQuantity',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //remove button
                    if (!isFavoriteCard) RemoveButton(onTap: onTapRemoveButton),
                    //heart button
                    CustomLikeButton(
                      isFavorited: isFavorited,
                      onTapFavouriteButton: onTapFavouriteButton,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
