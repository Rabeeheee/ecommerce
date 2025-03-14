class ProductOrder {
  final String vendorID;
  final String productName;
  final String productID;
  final num quantity;
  final num shippingCharge;
  final num price;
  final num color;

  ProductOrder({
    // required this.paymentID,
    required this.productName,
    required this.vendorID,
    required this.productID,
    required this.color,
    required this.quantity,
    required this.shippingCharge,
    required this.price,
  });
}
