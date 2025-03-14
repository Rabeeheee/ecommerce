import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/common/widgets/square_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';

class ProductImagesDisplayWidget extends StatelessWidget {
  const ProductImagesDisplayWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    CarouselSliderController  carouselController = CarouselSliderController();
    // context.read<DetailsPageBloc>().add(GetProductFavoriteDetailsEvent());
    void updateProductToFavorite(
        {required bool isFavorited, required Product product}) {
      // print('hello how are you');

      context.read<DetailsPageBloc>().add(UpdateProductToFavoriteDetailsEvent(
          product: product, isFavorited: isFavorited));
    }

    return BlocConsumer<DetailsPageBloc, DetailsPageState>(
      listener: (context, state) {
        // print(state);
        if (state is GetAllImagesForProductFailed) {
          Fluttertoast.showToast(msg: state.message);
        }
        if (state is UpdateProductToFavoriteSuccess) {
          Fluttertoast.showToast(msg: 'Favorite Updated SuccessFully');
          context.read<DetailsPageBloc>().add(GetProductFavoriteDetailsEvent());
        }
        if (state is UpdateProductToFavoriteFailed) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      buildWhen: (previous, current) => current is GetAllImagesForProductState,
      builder: (context, state) {
        if (state is GetAllImagesForProductSuccess) {
          context.read<DetailsPageBloc>().add(GetProductFavoriteDetailsEvent());
          return Stack(
            children: [
              CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: state.allImages[state.currentSelectedIndex]!.length,
                itemBuilder: (context, index, realIndex) {
                  List<model.Image> images =
                      state.allImages[state.currentSelectedIndex]!;
                  return Hero(
                    tag: product.productID,
                    child: CachedNetworkImage(
                      imageUrl: images[index].imageURL,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade100,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          width: double.infinity,
                          height: 350,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 350,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                ),
              ),
              Positioned(
                right: 10,
                top: 5,
                child: Column(
                  children: [
                    BlocBuilder<DetailsPageBloc, DetailsPageState>(
                      buildWhen: (previous, current) =>
                          current is GetProductFavoritedDetailsState,
                      builder: (context, state) {
                        // print(state);
                        // if (state is GetProductFavoritedDetailsSuccess) {
                        return CustomLikeButton(
                          isFavorited:
                              state is GetProductFavoritedDetailsSuccess &&
                                  state.favorited.contains(product.productID),
                          onTapFavouriteButton: (bool isLiked) async {
                            if (state is GetProductFavoritedDetailsSuccess) {
                              updateProductToFavorite(
                                  isFavorited: !isLiked, product: product);
                            } else {
                              // context
                              //     .read<DetailsPageBloc>()
                              //     .add(GetProductFavoriteDetailsEvent());
                            }
                            return !isLiked;
                          },
                        );
                        // }
                        // return Container();
                        // CustomLikeButton(
                        //   isFavorited: true,
                        //   onTapFavouriteButton: (bool isLiked) async {
                        //     updateProductToFavorite(
                        //         isFavorited: !isLiked, product: product);
                        //     return !isLiked;
                        //   },
                        // );
                      },
                    ),
                    // Constants.kHeight,
                    // const SquareButton(
                    //   icon: SvgIcon(
                    //     icon: CustomIcons.shareSvg,
                    //     color: AppPallete.greyTextColor,
                    //     radius: 5,
                    //     fit: BoxFit.scaleDown,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          );
        }
        return Stack(
          children: [
            CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: 1,
              itemBuilder: (context, index, realIndex) {
                return Hero(
                  tag: product.productID,
                  child: state is DetailsPageLoadingState
                      ? Image.network(product.displayImageURL)
                      : Image.network(product.displayImageURL),
                );
              },
              options: CarouselOptions(
                height: 350,
                viewportFraction: 1,
                enableInfiniteScroll: false,
              ),
            ),
            const Positioned(
              right: 10,
              top: 5,
              child: Column(
                children: [
                  SquareButton(
                    icon: SvgIcon(
                      icon: CustomIcons.heartSvg,
                      color: AppPallete.greyTextColor,
                      radius: 5,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  // Constants.kHeight,
                  // SquareButton(
                  //   icon: SvgIcon(
                  //     icon: CustomIcons.shareSvg,
                  //     color: AppPallete.greyTextColor,
                  //     radius: 5,
                  //     fit: BoxFit.scaleDown,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
