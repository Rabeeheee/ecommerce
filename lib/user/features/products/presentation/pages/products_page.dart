import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/common/widgets/product_card.dart';
import 'package:tech_haven/core/common/widgets/shopping_cart_button.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
// import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/user/features/products/presentation/bloc/products_page_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key, required this.searchQuery,this.isForSearch = false});

  final String searchQuery;
  final bool isForSearch;

  @override
  Widget build(BuildContext context) {
    void updateProductToFavorite(Product product, bool isLiked) {
      // print('updating the favorite');
      context.read<ProductsPageBloc>().add(
            UpdateProductToFavoriteProductsEvent(
              product: product,
              isFavorited: !isLiked,
            ),
          );
    }

    void updateProductToCart(
        {required Product product,
        required Cart? cart,
        required int itemCount}) {
      context.read<ProductsPageBloc>().add(
            UpdateProductToCartProductsEvent(
              product: product,
              itemCount: itemCount,
              cart: cart,
            ),
          );
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // If data is not loaded and not loading, fetch the data
      BlocProvider.of<ProductsPageBloc>(context)
          .add(GetAllProductsProductsEvent(
        searchQuery: searchQuery,
        isCategorySearch: true,
      ));
    });
    return Scaffold(
      appBar: isForSearch? null: const AppBarSearchBar(
        backButton: true,
      ),
      body: SizedBox(
        // height: 325,
        child: BlocConsumer<ProductsPageBloc, ProductsPageState>(
          listener: (context, state) {
            if (state is ProductsListViewProductsFailed) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          buildWhen: (previous, current) => current is ProductListViewState,
          builder: (context, listState) {
            // print(listState);
            if (listState is ProductsListViewProductsSuccess) {
              return listState.listOfProducts.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        mainAxisExtent: 300,
                      ),
                      itemCount: listState.listOfProducts.length,
                      itemBuilder: (context, index) {
                        final currentProduct = listState.listOfProducts[index];
                        return listState.listOfProducts.isNotEmpty
                            ? ProductCard(
                                onTapCard: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRouteConstants.detailsPage,
                                      extra: currentProduct);
                                },
                                likeButton: CustomLikeButton(
                                  isFavorited: listState.listOfFavoritedProducts
                                      .contains(currentProduct.productID),
                                  onTapFavouriteButton: (bool isLiked) async {
                                    updateProductToFavorite(
                                        currentProduct, isLiked);
                                    return isLiked ? false : true;
                                  },
                                ),
                                isHorizontal: false,
                                product: listState.listOfProducts[index],
                                // onTapFavouriteButton:
                                // isFavorited:
                                shoppingCartWidget: BlocBuilder<
                                    ProductsPageBloc, ProductsPageState>(
                                  buildWhen: (previous, current) =>
                                      current is ProductCartProductsState,
                                  builder: (context, cartState) {
                                    if (cartState
                                        is CartLoadedSuccessProductsState) {
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
                                      final cartIndex =
                                          checkCurrentProductIsCarted(
                                              product: listState
                                                  .listOfProducts[index],
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
                                              product: currentProduct,
                                              cart: cartState
                                                  .listOfCart[cartIndex],
                                              itemCount: cartState
                                                      .listOfCart[cartIndex]
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
                                              cart: cartState
                                                  .listOfCart[cartIndex],
                                              itemCount: cartState
                                                      .listOfCart[cartIndex]
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
                                            ? cartState.listOfCart[cartIndex]
                                                .productCount
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
                              )
                            : const Center(
                                child: Text(
                                  'No Data Found',
                                ),
                              );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No Product is found in this category',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 300,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ProductCard(
                    isHorizontal: true,
                    product: null,
                    likeButton: CustomLikeButton(
                      isFavorited: false,
                      onTapFavouriteButton: (bool isLiked) async {
                        return isLiked ? false : true;
                      },
                    ),
                    shoppingCartWidget: Container());
              },
            );
          },
        ),
      ),
    );
  }
}
