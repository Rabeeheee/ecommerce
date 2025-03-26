import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';

class CheckValidity {

  bool validateCartQuantities(List<Product> products, List<Cart> carts) {
  // Check if any product in cart has zero or insufficient quantity
  for (int i = 0; i < products.length; i++) {
    final cartIndex = checkCurrentProductIsCarted(
      product: products[i],
      carts: carts,
    );

    // If product is in cart, validate its quantity
    if (cartIndex > -1) {
      final cartedProduct = carts[cartIndex];
      
      // Check if carted quantity is zero or exceeds available stock
      if (cartedProduct.productCount <= 0 || 
          cartedProduct.productCount > products[i].quantity) {
        return false;
      }
    }
  }
  return true;
}

}