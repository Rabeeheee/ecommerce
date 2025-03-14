class VendorPayment {
  final DateTime dateTime;
  final String paymentID;
  final int totalAmount;
  final String orderID;
  final String vendorID;
  // final String vendorName;
  VendorPayment({required this.dateTime, required this.paymentID, required this.totalAmount, required this.orderID, required this.vendorID});
}
