import 'package:intl/intl.dart';
import 'package:tech_haven/core/common/data/model/product_order_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';

double calculateTotalPrize(
    {required List<Product> products, required List<Cart> carts}) {
  double sum = 0;
  for (var product in products) {
    final cartIndex =
        checkCurrentProductIsCarted(product: product, carts: carts);
    sum += product.prize * carts[cartIndex].productCount;
  }
  return sum;
}

double calculateTotalShipping(
    {required List<Product> products, required List<Cart> carts}) {
  double sum = 0;
  for (var product in products) {
    sum += product.shippingCharge ?? 0;
  }
  return sum;
}

calculateTotalQuantity({required List<Cart> listOfCarts}) {
  int quantity = 0;
  for (var cart in listOfCarts) {
    quantity += cart.productCount;
  }
  return quantity;
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

String changeAmountDecimal( {required int amount}) {
  return (amount / 100).toString();
}
 calculateTotalPrizeForVendorOrdrer(
      {required List<ProductOrderModel> productOrderModel}) {
    double sum = 0;
    for (var element in productOrderModel) {
      sum += (element.quantity * element.price) + element.shippingCharge;
      // sum = sum + element.shippingCharge;
    }
    return sum;
  }


  double calculateDiscountPercentage(num oldPrice, num offerPrice) {
  if (oldPrice <= 0 || offerPrice <= 0 || offerPrice >= oldPrice) {
    throw ArgumentError('Invalid input values');
  }
  
  num discount = oldPrice - offerPrice;
  double discountPercentage = (discount / oldPrice) * 100;
  
  // Round discountPercentage to two decimal places
  discountPercentage = double.parse(discountPercentage.toStringAsFixed(2));
  
  return discountPercentage;
}
