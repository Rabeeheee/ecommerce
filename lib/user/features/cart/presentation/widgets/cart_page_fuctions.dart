
// CartPageHelper class to contain extracted functions
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/cart_page_bottom_container.dart';

class CartPageHelper {
  // Controller management
  final List<TextEditingController> controllers = [];

  void generateTextEditingController(int length) {
    // Clear existing controllers to prevent memory leaks
    controllers.clear();
    for (int i = 0; i < length; i++) {
      controllers.add(TextEditingController());
    }
  }

  // Validation logic
  String validateCartQuantities(List<Product> products, List<Cart> carts) {
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

    // If no issues found, return empty string
    return '';
  }

  // Checkout logic
  void performCheckout(
    BuildContext context, 
    CartProductsListViewSuccess state, 
    ValueNotifier<bool> showBottomContainer
  ) {
    final validationMessage = validateCartQuantities(state.listOfProducts, state.listOfCarts);
    
    // Check if any validation issues exist
    if (validationMessage.isNotEmpty) {
      showSnackBar(
        context: context,
        title: 'Checkout Error',
        content: validationMessage,
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

  // Cart dialog display
  void showCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: BlocBuilder<CartPageBloc, CartPageState>(
            buildWhen: (previous, current) => current is CartProductsListViewSuccess,
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

  // Remove product confirmation
  Future<bool> removeProductFromCart({
    required BuildContext context,
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
}