import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';

int checkCurrentProductIsCarted(
    {required Product product, required List<Cart> carts}) {
  // for (var cart in carts) {
  // Check if the product ID in the cart exists in the list of products

 return
      carts.indexWhere((element) => element.productID == product.productID);

}
