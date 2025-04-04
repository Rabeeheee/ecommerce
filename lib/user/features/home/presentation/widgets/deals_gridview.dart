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
  const DealsGridView({super.key});

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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'MEGA DEALS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    '24 HOURS ONLY',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Grid of product cards
          BlocConsumer<HomePageBloc, HomePageState>(
            buildWhen: (previous, current) =>
                current is HorizontalProductListViewState,
            listener: (context, state) {},
            builder: (context, listState) {
              if (listState is HorizontalProductsListViewHomeSuccess) {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: listState.listOfProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final currentProduct = listState.listOfProducts[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: DealsProductCard(
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
                                      currentProduct, isLiked);
                                  return isLiked ? false : true;
                                },
                              );
                            }
                            return CustomLikeButton(
                              isFavorited: false,
                              onTapFavouriteButton: (bool isLiked) async {
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
                                  product: currentProduct,
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
                      ),
                    );
                  },
                );
              }
              // Placeholder loading cards
              return GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
