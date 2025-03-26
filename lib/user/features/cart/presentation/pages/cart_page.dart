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
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/cart_page_bottom_container.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/title_with_count_bar.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';
import 'package:tech_haven/user/features/favorite/presentation/bloc/favorite_page_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartPageBloc>().add(GetAllProductsEvent());
    });

    final ValueNotifier<bool> showBottomContainer = ValueNotifier(false);

  String _validateCartQuantities(List<Product> products, List<Cart> carts) {
      // Check if cart is empty
      if (carts.isEmpty) {
        return 'Your cart is empty';
      }

      for (int i = 0; i < carts.length; i++) {
        final cart = carts[i];
        final product = products.firstWhere(
          (p) => p.productID == cart.productID, 
          orElse: () => throw Exception('Product not found')
        );

        // Check for zero or negative quantity
        if (cart.productCount <= 0) {
          return 'Product "${product.name}" has an invalid quantity';
        }

        // Check if requested quantity exceeds available stock
        if (cart.productCount > product.quantity) {
          return 'Requested quantity for "${product.name}" exceeds available stock';
        }
      }

      // If no issues found, return null (or empty string)
      return '';
    }

    void _performCheckout(BuildContext context, CartProductsListViewSuccess state) {

      final validarionMessage = _validateCartQuantities(state.listOfProducts, state.listOfCarts);
      // Check if any products have zero quantity
      if (validarionMessage.isNotEmpty) {
        showSnackBar(
          context: context,
          title: 'Checkout Error',
          content: 'Some items have 0 quantity. Please adjust your cart.',
          contentType: ContentType.failure,
        );
      } else {
        // Proceed with checkout
        if (Responsive.isMobile(context)) {
          showBottomContainer.value = true;
        } else {
          showCartDialog(context);
        }
      }
    }

    Future<bool> removeProductFromCart({
      required Product product,
      required Cart cart,
    }) async {
      final boolean = await showConfirmationDialog(
        context,
        'Remove From Carts',
        'Are You Sure You Want To Remove this Product From Carts',
        () {
          context.read<CartPageBloc>().add(
            UpdateProductToCartEvent(
              itemCount: 0,
              product: product,
              cart: cart,
            ),
          );
        },
      );
      return boolean!;
    }

    List<TextEditingController> controllers = [];

    void generateTextEditingController(int length) {
      // Clear existing controllers to prevent memory leaks
      controllers.clear();
      for (int i = 0; i < length; i++) {
        controllers.add(TextEditingController());
      }
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state is AllCartsClearedSuccessState) {
              controllers = [];
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
              controllers = [];
              context.read<CartPageBloc>().add(GetAllProductsEvent());
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarSearchBar(),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: AppPallete.lightgreyColor,
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<CartPageBloc, CartPageState>(
                        buildWhen: (previous, current) =>
                            current is CartProductListViewState,
                        builder: (context, listState) {
                          if (listState is CartProductsListViewSuccess) {
                            return listState.listOfCarts.isNotEmpty
                                ? TitleWithCountBar(
                                    title: 'Cart',
                                    itemsCount:
                                        '${calculateTotalQuantity(listOfCarts: listState.listOfCarts)} Items',
                                    totalPrize:
                                        'AED ${calculateTotalPrize(products: listState.listOfProducts, carts: listState.listOfCarts)}',
                                  )
                                : const Center(
                                    child: Text('Your Cart is Empty'),
                                  );
                          }
                          return const TitleWithCountBar(
                            title: 'Cart',
                            itemsCount: '0 Items',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocConsumer<CartPageBloc, CartPageState>(
                    listener: (context, state) {
                      if (state is CartUpdatedSuccess) {
                        showSnackBar(
                                    context: context,
                                    title: 'cart',
                                    content: 'The Cart Updated Successfully',
                                    contentType: ContentType.success,
                                  );
                        context.read<CartPageBloc>().add(GetAllProductsEvent());
                      }

                      if (state is ProductUpdatedToFavoriteCartSuccess) {
                         showSnackBar(
                                    context: context,
                                    title: 'Favorite',
                                    content: 'Favorite Updated Successfully',
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
                        generateTextEditingController(
                          listState.listOfProducts.length,
                        );
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisExtent: 275,
                            maxCrossAxisExtent: 550,
                          ),
                          itemCount: listState.listOfProducts.length,
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
                              controllers[index].text =
                                  listState.listOfCarts[cartIndex].productCount
                                      .toString();
                            } else {
                              // Default to 0 if not in cart
                              controllers[index].text = '0';
                            }

                            return RectangularProductCard(
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
                                  removeProductFromCart(
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
                              textEditingController: controllers[index],
                              onPressedSaveButton: () {
                                final newCount = int.parse(
                                  controllers[index].text,
                                );
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
                            );
                          },
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 275,
                          maxCrossAxisExtent: 550,
                        ),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return RectangularProductCard(
                            isLoading: true,
                            onTap: () {},
                            isFavoriteCard: false,
                            productName:
                                ' Sony PlayStation 5 Console (Disc Version) With Controller',
                            productPrize: '2888',
                            vendorName: 'Mohammed Rayid',
                            deliveryDate: 'Tomorrow 5 March',
                            productImage: null,
                            textEditingController: null,
                            productQuantity: '0',
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
                return state is CartProductsListViewSuccess &&
                        state.listOfCarts.isNotEmpty
                    ? ValueListenableBuilder(
                      valueListenable: showBottomContainer,
                      builder: (context, value, child) {
                        return !showBottomContainer.value
                            ? Positioned(
                              bottom: 100,
                              right: 10,
                              child: Container(
                                height: 35,
                                width: 180,
                                color: Colors.white,
                                child: PrimaryAppButton(
                                  onPressed: () {
                                    final state = context.read<CartPageBloc>().state;
                                    if(state is CartProductsListViewSuccess){
                                      _performCheckout(context, state);
                                    }
                                    if (Responsive.isMobile(context)) {
                                      showBottomContainer.value = true;
                                    } else {
                                      showCartDialog(context);
                                    }
                                  },
                                  buttonText: 'CHECKOUT',
                                ),
                              ),
                            )
                            : const SizedBox();
                      },
                    )
                    : Container();
              },
            ),
          ],
        ),
        // floatingActionButton:
        bottomNavigationBar: BlocBuilder<CartPageBloc, CartPageState>(
          buildWhen: (previous, current) => current is CartProductListViewState,
          builder: (context, listState) {
            return ValueListenableBuilder<bool>(
              valueListenable: showBottomContainer,
              builder: (context, value, child) {
                if (value && listState is CartProductsListViewSuccess) {
                   debugPrint('listOfProducts length: ${listState.listOfProducts.length}');
          debugPrint('listOfCarts length: ${listState.listOfCarts.length}');
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
                      ? Stack(
                        children: [
                          CartPageBottomContainer(
                            listOfCart: listState.listOfCarts,
                            subTotal: subTotal,
                            totalShpping: totalShpping,
                            total: total,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
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
                      )
                      : const SizedBox();
                }
                return const SizedBox();
              },
            );
          },
        ),
      ),
    );
  }

  void showCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: BlocBuilder<CartPageBloc, CartPageState>(
            buildWhen:
                (previous, current) => current is CartProductsListViewSuccess,
            builder: (context, state) {
              if (state is CartProductsListViewSuccess) {
                final double subTotal = calculateTotalPrize(
                  products: state.listOfProducts,
                  carts: state.listOfCarts,
                );

                final double totalShpping = calculateTotalShipping(
                  products: state.listOfProducts,
                  carts: state.listOfCarts,
                );

                final double total = subTotal + totalShpping;

                return total > 0
                    ? Stack(
                      children: [
                        CartPageBottomContainer(
                          isDialog: true,
                          listOfCart: state.listOfCarts,
                          subTotal: subTotal,
                          totalShpping: totalShpping,
                          total: total,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircularButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            circularButtonChild: const SvgIcon(
                              icon: CustomIcons.angleDownSvg,
                              radius: 16,
                            ),
                            diameter: 35,
                          ),
                        ),
                      ],
                    )
                    : const SizedBox();
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}
