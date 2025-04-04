import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/common/widgets/rectangular_product_card.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/cart_header.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/cart_page_bottom_container.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/cart_page_fuctions.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';
import 'package:tech_haven/user/features/favorite/presentation/bloc/favorite_page_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create helper instance
    final CartPageHelper helper = CartPageHelper();
    final ValueNotifier<bool> showBottomContainer = ValueNotifier(false);
    
    // Fetch products when page loads
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartPageBloc>().add(GetAllProductsEvent());
    });

    return MultiBlocListener(
      listeners: [
        BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is AllCartsClearedSuccessState) {
              helper.controllers.clear(); // Clear controllers
              context.read<CartPageBloc>().add(GetAllProductsEvent());
            }
          },
        ),
        BlocListener<DetailsPageBloc, DetailsPageState>(
          listener: (context, state) {
            if (state is CartLoadedSuccessDetailsState ||
                state is CartLoadedSuccessDetailsPageRelatedState ||
                state is UpdateProductToFavoriteSuccess) {
              context.read<CartPageBloc>().add(GetAllProductsEvent());
            }
          },
        ),
        BlocListener<FavoritePageBloc, FavoritePageState>(
          listener: (context, state) {
            if (state is FavoriteRemovedSuccess ||
                state is FavoritePageLoadedSuccess) {
              helper.controllers.clear(); // Clear controllers
              context.read<CartPageBloc>().add(GetAllProductsEvent());
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppPallete.offWhite,
        appBar: const AppBarSearchBar(),
        body: Stack(
          children: [
            Column(
              children: [
                const CartHeader(), 
                Expanded( 
                  child: BlocConsumer<CartPageBloc, CartPageState>(
                    listener: (context, state) {
                      if (state is CartUpdatedSuccess) {
                        showSnackBar(
                          context: context,
                          title: 'Cart',
                          content: 'The Cart Updated Successfully',
                          contentType: ContentType.success,
                        );
                        context.read<CartPageBloc>().add(GetAllProductsEvent());
                      }
                  
                      if (state is ProductUpdatedToFavoriteCartSuccess) {
                        showSnackBar(
                          context: context,
                          title: 'Favorite',
                          content: 'Favorite Added Successfully',
                          contentType: ContentType.success,
                        );
                      }
                  
                      if (state is ProductUpdatedToFavoriteCartFailed) {
                        Fluttertoast.showToast(msg: state.message);
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is CartProductListViewState,
                    builder: (context, listState) {
                      if (listState is CartProductsListViewSuccess) {
                        helper.generateTextEditingController(
                          listState.listOfProducts.length,
                        );
                        
                        // If no products, show empty state
                        if (listState.listOfProducts.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 80,
                                  color: Colors.black45,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Your cart is empty',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Start shopping to add items to your cart',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        
                        return ListView( // Changed to ListView for better scrolling behavior
                          children: [
                            GridView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisExtent: 190,
                                maxCrossAxisExtent: 550,
                                mainAxisSpacing: 12, 
                                crossAxisSpacing: 16,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: listState.listOfProducts.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final currentProduct =
                                    listState.listOfProducts[index];
                                bool productIsCarted = false;
                                
                                // Safely check if product is in cart
                                final cartIndex = checkCurrentProductIsCarted(
                                  product: listState.listOfProducts[index],
                                  carts: listState.listOfCarts,
                                );
                      
                                // Initialize controller text based on cart status
                                if (cartIndex > -1 && listState.listOfCarts.isNotEmpty) {
                                  productIsCarted = true;
                                  helper.controllers[index].text =
                                      listState.listOfCarts[cartIndex].productCount
                                          .toString();
                                } else {
                                  // Default to 0 if not in cart
                                  helper.controllers[index].text = '0';
                                }
                      
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        // ignore: deprecated_member_use
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: RectangularProductCard(
                                      isFavorite: listState.listOfFavorites.contains(
                                        currentProduct.productID,
                                      ),
                                      isLoading: false,
                                      onTap: () {
                                        GoRouter.of(context).pushNamed(
                                          AppRouteConstants.detailsPage,
                                          extra: currentProduct,
                                        );
                                      },
                                      onTapFavouriteButton: (bool isLiked) async {
                                        context.read<CartPageBloc>().add(
                                          UpdateProductToFavoriteEvent(
                                            product: currentProduct,
                                            isFavorited: !isLiked,
                                          ),
                                        );
                                        return !isLiked;
                                      },
                                      onTapRemoveButton: () {
                                        // Only remove if product is actually in cart
                                        if (cartIndex > -1 && listState.listOfCarts.isNotEmpty) {
                                          helper.removeProductFromCart(
                                            context: context,
                                            product: currentProduct,
                                            cart: listState.listOfCarts[cartIndex],
                                          );
                                        }
                                      },
                                      isFavoriteCard: false,
                                      productName: currentProduct.name,
                                      productPrize: currentProduct.prize.toString(),
                                      vendorName: currentProduct.vendorName,
                                      deliveryDate: currentProduct.brandName,
                                      productImage: currentProduct.displayImageURL,
                                      productQuantity:
                                          currentProduct.quantity.toString(),
                                      textEditingController: helper.controllers[index],
                                      onPressedSaveButton: () {
                                        final newCount = int.tryParse(
                                          helper.controllers[index].text,
                                        ) ?? 0;
                                        if (currentProduct.quantity >= newCount &&
                                            newCount > 0) {
                                          if (productIsCarted && cartIndex > -1) {
                                            context.read<CartPageBloc>().add(
                                              UpdateProductToCartEvent(
                                                itemCount: newCount,
                                                product: currentProduct,
                                                cart: listState.listOfCarts[cartIndex],
                                              ),
                                            );
                                          }
                                        } else {
                                          showSnackBar(
                                            context: context,
                                            title: 'Amount',
                                            content: 'Give a valid Quantity',
                                            contentType: ContentType.failure,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                      
                      // Loading state with shimmer effect
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 280,
                          maxCrossAxisExtent: 550,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: 6,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: RectangularProductCard(
                                isLoading: true,
                                onTap: () {},
                                isFavoriteCard: false,
                                productName: 'Loading...',
                                productPrize: '...',
                                vendorName: '...',
                                deliveryDate: '...',
                                productImage: null,
                                textEditingController: null,
                                productQuantity: '0',
                                isFavorite: false, // Added missing required property
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
        
            BlocBuilder<CartPageBloc, CartPageState>(
              builder: (context, state) {
                if (state is CartProductsListViewSuccess && state.listOfCarts.isNotEmpty) {
                  return ValueListenableBuilder(
                    valueListenable: showBottomContainer,
                    builder: (context, value, child) {
                      return !showBottomContainer.value
                          ? Positioned(
                              bottom: 24,
                              right: 24,
                              child: Container(
                                height: 45,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: AppPallete.primaryBlack,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      // ignore: deprecated_member_use
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: PrimaryAppButton(
                                  onPressed: () {
                                    final state = context.read<CartPageBloc>().state;
                                    if(state is CartProductsListViewSuccess){
                                      helper.performCheckout(context, state, showBottomContainer);
                                    }
                                  },
                                  buttonText: 'CHECKOUT',
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        bottomNavigationBar: BlocBuilder<CartPageBloc, CartPageState>(
          buildWhen: (previous, current) => current is CartProductListViewState,
          builder: (context, listState) {
            if (listState is CartProductsListViewSuccess) {
              return ValueListenableBuilder<bool>(
                valueListenable: showBottomContainer,
                builder: (context, value, child) {
                  if (value) {
                    final double subTotal =
                        listState.listOfProducts.isNotEmpty &&
                                listState.listOfCarts.isNotEmpty
                            ? calculateTotalPrize(
                              products: listState.listOfProducts,
                              carts: listState.listOfCarts,
                            )
                            : 0.0;

                    final double totalShpping =
                        listState.listOfProducts.isNotEmpty &&
                                listState.listOfCarts.isNotEmpty
                            ? calculateTotalShipping(
                              products: listState.listOfProducts,
                              carts: listState.listOfCarts,
                            )
                            : 0.0;

                    final double total = subTotal + totalShpping;
                    
                    return total > 0
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, -5),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                CartPageBottomContainer(
                                  listOfCart: listState.listOfCarts,
                                  subTotal: subTotal,
                                  totalShpping: totalShpping,
                                  total: total,
                                ),
                                Positioned(
                                  right: 12,
                                  top: 12,
                                  child: CircularButton(
                                    onPressed: () {
                                      showBottomContainer.value = false;
                                    },
                                    circularButtonChild: const SvgIcon(
                                      icon: CustomIcons.angleDownSvg,
                                      radius: 16,
                                    ),
                                    diameter: 35,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox();
                  }
                  return const SizedBox();
                },
              );
            }
            return const SizedBox(); 
          },
        ),
      ),
    );
  }
}