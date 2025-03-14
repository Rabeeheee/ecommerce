import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/shopping_cart_button.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/core/common/widgets/product_card.dart';
// import 'package:shimmer/shimmer.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    void updateProductToFavorite(Product product, bool isLiked) {
      context.read<HomePageBloc>().add(
            UpdateProductToFavoriteHomeEvent(
              product: product,
              isFavorited: !isLiked,
            ),
          );
    }

    void updateProductToCart(
        {required Product product,
        required Cart? cart,
        required int itemCount}) {
      context.read<HomePageBloc>().add(
            UpdateProductToCartHomeEvent(
              product: product,
              itemCount: itemCount,
              cart: cart,
            ),
          );
    }

    return Container(
      alignment: Alignment.center,
      height: 360,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: GlobalTitleText(
              title: 'Recommended for you',
            ),
          ),
          //container for the whole
          SizedBox(
            height: 325,
            child: BlocConsumer<HomePageBloc, HomePageState>(
              buildWhen: (previous, current) =>
                  current is HorizontalProductListViewState,
              listener: (context, state) {
                if (state is HorizontalProductsListViewHomeFailed) {
                  return showSnackBar(
                      context: context,
                      title: 'Oh',
                      content: state.message,
                      contentType: ContentType.failure);
                }

                if (state is CartLoadedFailedHomeState) {
                  showSnackBar(
                      context: context,
                      title: 'Oh',
                      content: state.message,
                      contentType: ContentType.failure);

                  context.read<HomePageBloc>().add(GetAllCartHomeEvent());
                }
                //toast for adding product to the cart
                // if (state is ProductUpdatedToCartHomeSuccess) {
                //   Fluttertoast.showToast(
                //       msg: "The Cart is Updated Successfully",
                //       toastLength: Toast.LENGTH_SHORT,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor: Colors.green,
                //       textColor: Colors.white,
                //       fontSize: 16.0);

                //   context.read<HomePageBloc>().add(GetAllCartHomeEvent());
                // }
                if (state is ProductUpdatedToCartHomeFailed) {
                  Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  context.read<HomePageBloc>().add(GetAllCartHomeEvent());
                }
                if (state is FavoriteLoadedFailedHomeState) {
                  showSnackBar(
                      context: context,
                      title: 'Oh',
                      content: state.message,
                      contentType: ContentType.failure);

                  context.read<HomePageBloc>().add(GetAllFavoriteHomeEvent());
                }
                if (state is ProductUpdatedToFavoriteHomeSuccess) {
                  Fluttertoast.showToast(
                      msg: "The Favorites is Updated Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  context.read<HomePageBloc>().add(GetAllFavoriteHomeEvent());
                }
                if (state is ProductUpdatedToFavoriteHomeFailed) {
                  Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  context.read<HomePageBloc>().add(GetAllFavoriteHomeEvent());
                }
              },
              builder: (context, listState) {
                if (listState is HorizontalProductsListViewHomeSuccess) {
                  // if(listState.)
                  // print(listState.listOfProducts);
                  // print('object');
                  return ScrollConfiguration(
behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
  PointerDeviceKind.touch,
  PointerDeviceKind.stylus,
  PointerDeviceKind.mouse,
},),
                    child: ListView.builder(
                      // physics: const BouncingScrollPhysics(),
                      scrollDirection:
                          Axis.horizontal, // Set scroll direction to horizontal
                      itemCount: listState.listOfProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final currentProduct = listState.listOfProducts[index];
                        //column since the container is divided into two
                        return ProductCard(
                          likeButton: BlocBuilder<HomePageBloc, HomePageState>(
                            buildWhen: (previous, current) =>
                                current is ProductFavoriteHomeState,
                            builder: (context, favstate) {
                              if (favstate is FavoriteLoadedSuccessHomeState) {
                                return CustomLikeButton(
                                  isFavorited: favstate.listOfFavorite
                                      .contains(currentProduct.productID),
                                  onTapFavouriteButton: (bool isLiked) async {
                                    updateProductToFavorite(
                                        listState.listOfProducts[index], isLiked);
                                    return isLiked ? false : true;
                                  },
                                );
                              }
                              return CustomLikeButton(
                                isFavorited: false,
                                onTapFavouriteButton: (bool isLiked) async {
                                  // updateProductToFavorite(
                                  //     listState.listOfProducts[index], isLiked);
                                  return isLiked ? false : true;
                                },
                              );
                            },
                          ),
                          onTapCard: () {
                            GoRouter.of(context).pushNamed(
                                AppRouteConstants.detailsPage,
                                extra: currentProduct);
                          },
                          // isFavorited: listState.listOfFavoritedProducts
                          //     .contains(currentProduct.productID),
                          // index: index,
                          isHorizontal: true,
                          product: currentProduct,
                          // onTapFavouriteButton: (bool isLiked) async {
                          //   updateProductToFavorite(currentProduct, isLiked);
                          //   return isLiked ? false : true;
                          // },
                          shoppingCartWidget:
                              BlocBuilder<HomePageBloc, HomePageState>(
                            buildWhen: (previous, current) =>
                                current is ProductCartHomeState,
                            builder: (context, cartState) {
                              if (cartState is CartLoadedSuccessHomeState) {
                                ///if index =  0, then it will return -1 if the product is not carted
                                ///if index = 1, then it will return -1
                                ///if index = 2 , then it will return -1
                                ///
                                ///if there is product it will return the cart index
                    
                                // final Product product =
                                //     listState.listOfProducts[index];
                                // final Cart cart = cartState.listOfCart.firstWhere(
                                //   (cart) => cart.productID == product.productID,
                                // );
                                bool productIsCarted = false;
                                final cartIndex = checkCurrentProductIsCarted(
                                    product: listState.listOfProducts[index],
                                    carts: cartState.listOfCart);
                    
                                if (cartIndex > -1) {
                                  productIsCarted = true;
                                }
                    
                                // print(productIsCarted);
                    
                                return ShoppingCartButton(
                                  onTapPlusButton: () {
                                    if (productIsCarted &&
                                        cartState.listOfCart[cartIndex]
                                                .productCount <=
                                            currentProduct.quantity) {
                                      updateProductToCart(
                                        product: currentProduct,
                                        cart: cartState.listOfCart[cartIndex],
                                        itemCount: cartState.listOfCart[cartIndex]
                                                .productCount +
                                            1,
                                      );
                                      //if the product is not carted yet . then we increase it by one
                                    } else if (!productIsCarted) {
                                      updateProductToCart(
                                        product: currentProduct,
                                        cart: null,
                                        itemCount: 1,
                                      );
                                    }
                                  },
                                  onTapMinusButton: () {
                                    if (productIsCarted &&
                                        cartState.listOfCart[cartIndex]
                                                    .productCount -
                                                1 >=
                                            0) {
                                      updateProductToCart(
                                        product: currentProduct,
                                        cart: cartState.listOfCart[cartIndex],
                                        itemCount: cartState.listOfCart[cartIndex]
                                                .productCount -
                                            1,
                                      );
                                    }
                                    //if there is no product carted and the user clicks '-' then we show a
                                    if (!productIsCarted) {
                                      Fluttertoast.showToast(
                                        msg: 'Add Product To Cart First',
                                      );
                                    }
                                  },
                                  onTapCartButton: () {},
                                  currentCount: productIsCarted
                                      ? cartState
                                          .listOfCart[cartIndex].productCount
                                      : 0,
                                  isLoading: false,
                                );
                              }
                              return const ShoppingCartButton(
                                currentCount: 0,
                                isLoading: true,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
                return ListView.builder(
                  // physics: const BouncingScrollPhysics(),
                  scrollDirection:
                      Axis.horizontal, // Set scroll direction to horizontal
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    //column since the container is divided into two
                    return ProductCard(
                      // index: index,

                      likeButton: CustomLikeButton(
                        isFavorited: false,
                        onTapFavouriteButton: (bool isLiked) async {
                          return isLiked ? false : true;
                        },
                      ),
                      // index: index,
                      isHorizontal: true,
                      product: null,

                      shoppingCartWidget: ShoppingCartButton(
                        onTapPlusButton: () {},
                        onTapMinusButton: () {},
                        onTapCartButton: () {},
                        currentCount: 10,
                        isLoading: false,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
