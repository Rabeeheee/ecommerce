import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/common/widgets/shopping_cart_button.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/deals_product_card.dart';

class DealsGridView extends StatelessWidget {
  const DealsGridView({
    super.key,
  });

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

    void updateProductToCart(BuildContext context,
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
      height: 670,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        'MEGA DEALS',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        '24 HOURS ONLY',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 25,
              //   width: 125,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppPallete.blackColor,
              //       foregroundColor: AppPallete.whiteColor,
              //       shape: const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(5),
              //         ),
              //       ),
              //     ),
              //     child: const Text(
              //       'VIEW ALL',
              //       style: TextStyle(
              //         color: AppPallete.whiteColor,
              //         fontSize: 12,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          // Container for the product card
          Container(
            height: 600,
            margin: const EdgeInsets.only(top: 20),
            child: BlocConsumer<HomePageBloc, HomePageState>(
              buildWhen: (previous, current) =>
                  current is HorizontalProductListViewState,
              listener: (context, state) {},
              builder: (context, listState) {
                if (listState is HorizontalProductsListViewHomeSuccess) {
                  return GridView.builder(
                    itemCount: listState.listOfProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 1 / 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      maxCrossAxisExtent: 300,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final currentProduct = listState.listOfProducts[index];
                      return DealsProductCard(
                        likeButton: BlocBuilder<HomePageBloc, HomePageState>(
                          buildWhen: (previous, current) =>
                              current is ProductFavoriteHomeState,
                          builder: (context, favstate) {
                            // print(favstate is FavoriteLoadedSuccessHomeState);
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
                        isHorizontal: true,
                        product: currentProduct,
                        shoppingCartWidget:
                            BlocBuilder<HomePageBloc, HomePageState>(
                          buildWhen: (previous, current) =>
                              current is ProductCartHomeState,
                          builder: (context, cartState) {
                            if (cartState is CartLoadedSuccessHomeState) {
                              bool productIsCarted = false;
                              final cartIndex = checkCurrentProductIsCarted(
                                  product: listState.listOfProducts[index],
                                  carts: cartState.listOfCart);

                              if (cartIndex > -1) {
                                productIsCarted = true;
                              }

                              return ShoppingCartButton(
                                onTapPlusButton: () {
                                  if (productIsCarted &&
                                      cartState.listOfCart[cartIndex]
                                              .productCount <=
                                          currentProduct.quantity) {
                                    updateProductToCart(
                                      context,
                                      product: currentProduct,
                                      cart: cartState.listOfCart[cartIndex],
                                      itemCount: cartState.listOfCart[cartIndex]
                                              .productCount +
                                          1,
                                    );
                                  } else if (!productIsCarted) {
                                    updateProductToCart(
                                      context,
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
                                      context,
                                      product: currentProduct,
                                      cart: cartState.listOfCart[cartIndex],
                                      itemCount: cartState.listOfCart[cartIndex]
                                              .productCount -
                                          1,
                                    );
                                  }
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
                  );
                }
                return GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 1 / 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    maxCrossAxisExtent: 300,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DealsProductCard(
                      likeButton: CustomLikeButton(
                        isFavorited: false,
                        onTapFavouriteButton: (bool isLiked) async {
                          return isLiked ? false : true;
                        },
                      ),
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
