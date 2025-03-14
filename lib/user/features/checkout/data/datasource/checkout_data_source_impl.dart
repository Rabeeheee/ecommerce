import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter_stripe_web/flutter_stripe_web.dart';
import 'package:http/http.dart' as http;
import 'package:tech_haven/core/common/data/model/address_details_model.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/common/data/model/payment_model.dart';
import 'package:tech_haven/core/common/data/model/product_order_model.dart';
import 'package:tech_haven/core/common/data/model/user_ordered_product_model.dart';
import 'package:tech_haven/core/common/data/model/vendor_payment_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/user.dart' as model;
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';
import 'package:uuid/uuid.dart';

class CheckoutDataSourceImpl implements CheckoutDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  CheckoutDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseAuth});
  @override
  Future<PaymentIntentModel> submitPaymentForm(
      {required String name,
      required String address,
      required String pin,
      required String city,
      required String state,
      required String country,
      required String currency,
      required String amount}) async {
    // print('sdfsdfsd');
    try {
      final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
      String? secretKey;
      if (!kIsWeb) {
        secretKey = dotenv.env["STRIPE_SECRET_KEY"]!;
      }

      final body = {
        'amount': amount,
        'currency': currency.toLowerCase(),
        'automatic_payment_methods[enabled]': 'true',
        'description': "Test Donation",
        'shipping[name]': name,
        'shipping[address][line1]': address,
        'shipping[address][postal_code]': pin,
        'shipping[address][city]': city,
        'shipping[address][state]': state,
        'shipping[address][country]': country
      };

      final response = await http.post(url,
          headers: {
            "Authorization": kIsWeb
                ? "Bearer sk_test_51PITFLIhpYTVpxkBNiZJBhx7dykQdGYwNOecnnjCxaZ0hpXuTqlqQQBHL2Kh3VIq4vfklyw70BqWfaRed7H3aXrD003YCcU8S7"
                : "Bearer $secretKey",
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: body);
      PaymentIntentModel paymentIntentModel;
      dynamic jsonResponse;
      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(response.body);
        debugPrint(response.body);
        // print(jsonResponse);
        // Create a PaymentIntentModel object from the JSON response
        paymentIntentModel = PaymentIntentModel.fromJson(jsonResponse);
        // print('okda mone');
        // Use debugPrint to output the paymentIntentModel details
        // debugPrint('Payment Intent: ${paymentIntentModel.toJson()}');
        // print('hello how are you ');
      } else {
        throw ServerException(response.reasonPhrase.toString());
      }
      if (!kIsWeb) {
        await initPaymentSheet(data: jsonResponse);
      }
      return paymentIntentModel;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        throw const ServerException(
            'The payment flow has been canceled. Please try again.');
      } else {
        throw ServerException('Stripe error: ${e.error.toString()}');
      }
    } catch (e) {
      // Handle other errors
      throw ServerException('Unknown error: ${e.toString()}');
    }
  }
// import 'package:stripe/stripe.dart';

  Future<void> initPaymentSheet({required dynamic data}) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.dark,
        ),
      );
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        throw const ServerException(
            'The payment flow has been canceled. Please try again.');
      } else {
        throw ServerException('Stripe error: ${e.error.toString()}');
      }
    } catch (e) {
      // Handle other errors
      throw ServerException('Unknown error: ${e.toString()}');
    }
  }

  @override
  Future<PaymentIntentModel> showPresentPaymentSheet(
      {required PaymentIntentModel paymentIntentModel}) async {
    try {
      if (!kIsWeb) {
        await Stripe.instance
            .presentPaymentSheet(options: const PaymentSheetPresentOptions());
      }

      return paymentIntentModel;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        throw const ServerException(
            'The payment flow has been canceled. Please try again.');
      } else {
        throw ServerException('Stripe error: ${e.error.toString()}');
      }
    } catch (e) {
      // Handle other errors
      throw ServerException('Unknown error: ${e.toString()}');
    }
  }

  @override
  Future<String> sendOrder({
    required PaymentIntentModel paymentIntentModel,
    required List<Product> products,
    required List<Cart> carts,
    required model.User user,
  }) async {
    try {
      String orderID = const Uuid().v4();

      DateTime orderDateWithTime = DateTime.now();

      List<ProductOrderModel> listOfProductOrderModel = [];

      Map<String, List<ProductOrderModel>> mapOfvendorProducts = {};
      // print('start');
      // Populate mapOfvendorProducts and listOfProductOrderModel

      for (int i = 0; i < carts.length; i++) {
        print(1);
        // print(carts[i].productID);
        Product product = products
            .firstWhere((element) => element.productID == carts[i].productID);
        await firebaseFirestore
            .collection('userOrderedProducts')
            .doc(user.uid)
            .collection('orders')
            .doc(
              orderID,
            )
            .collection('products')
            .doc(product.productID)
            .set(UserOrderedProductModel(
              shippingCharge: product.shippingCharge ?? 0,
              brandID: product.brandID,
              productID: product.productID,
              orderID: orderID,
              vendorName: product.vendorName,
              brandName: product.brandName,
              dateTime: orderDateWithTime,
              quantity: carts[i].productCount,
              displayImageURL: product.displayImageURL,
              name: product.name,
              prize: product.prize,
              oldPrize: product.oldPrize,
              vendorID: product.vendorID,
              specifications: product.specifications ?? {},
              mainCategory: product.mainCategory,
              mainCategoryID: product.mainCategoryID,
              subCategory: product.subCategory,
              subCategoryID: product.subCategoryID,
              variantCategory: product.variantCategory,
              variantCategoryID: product.variantCategoryID,
              overview: product.overview,
              color: 0,
            ).toJson());
        print(2);
        if (mapOfvendorProducts[product.vendorID] != null) {
          mapOfvendorProducts[product.vendorID]!.add(ProductOrderModel(
            vendorID: product.vendorID,
            shippingCharge: product.shippingCharge ?? 0,
            productID: carts[i].productID,
            quantity: carts[i].productCount,
            price: product.prize,
            productName: product.name,
            color: 0,
          ));
        } else {
          mapOfvendorProducts[product.vendorID] = [
            ProductOrderModel(
              productName: product.name,
              shippingCharge: product.shippingCharge ?? 0,
              vendorID: product.vendorID,
              productID: carts[i].productID,
              quantity: carts[i].productCount,
              price: product.prize,
              color: 0,
            )
          ];
        }
        // print(product.vendorID);
        print(3);
        listOfProductOrderModel.add(ProductOrderModel(
          vendorID: product.vendorID,
          productName: product.name,
          productID: carts[i].productID,
          shippingCharge: product.shippingCharge ?? 0,
          quantity: carts[i].productCount,
          price: product.prize,
          color: 0,
        ));
      }
      print(4);
      // print('iterate finished');
      for (var entry in mapOfvendorProducts.entries) {
        var vendorID = entry.key;
        VendorPaymentModel vendorPaymentModel = VendorPaymentModel(
          vendorID: vendorID,
          dateTime: orderDateWithTime,
          paymentID: paymentIntentModel.id,
          totalAmount: paymentIntentModel.amount,
          orderID: orderID,
        );
        // RevenueModel(currentBalance: currentBalance, vendorID: vendorID, withdrewAmount: withdrewAmount)
        // print(2);
        print(5);
        await firebaseFirestore.collection('revenues').doc(vendorID).set({
          'currentBalance': FieldValue.increment(
            calculateTotalPrizeForVendorOrdrer(
              productOrderModel: entry.value,
            ),
          )
        }, SetOptions(merge: true));
        print(6);
        await firebaseFirestore
            .collection('revenues')
            .doc(vendorID)
            .collection('paymentHistory')
            .doc(orderID)
            .set(vendorPaymentModel.toJson());
        // print(3);
        // await firebaseFirestore
        //     .collection('revenues')
        //     .doc(vendorID)
        //     .collection('paymentHistory')
        //     .doc(orderID)
        //     .set(paymentIntentModel.toJson());
        //first we create a vendor id with some data
        // print('addding data to vendororder');
        print(7);
        await firebaseFirestore
            .collection('vendorOrders')
            .doc(vendorID)
            .set(vendorPaymentModel.toJson());

        final OrderModel orderModel = OrderModel(
          orderID: orderID,
          orderDate: orderDateWithTime,
          deliveryDate: orderDateWithTime.add(const Duration(days: 7)),
          products: entry.value,
          userID: user.uid!,
          deliveredProducts: [],
          paymentID: paymentIntentModel.id,
          name: paymentIntentModel.shippingModel.name,
          address: paymentIntentModel.shippingModel.addressModel.line1,
          pin: paymentIntentModel.shippingModel.addressModel.postalCode,
          city: paymentIntentModel.shippingModel.addressModel.city,
          state: paymentIntentModel.shippingModel.addressModel.state,
          country: paymentIntentModel.shippingModel.addressModel.country,
          currency: paymentIntentModel.currency,
          totalAmount: paymentIntentModel.amount,
        );
        print(8);
        await firebaseFirestore
            .collection('vendorOrders')
            .doc(vendorID)
            .collection('orderDetails')
            .doc(orderID)
            .set(orderModel.toJson());
      }
      // print('adding data to userorder');
      final OrderModel orderModel = OrderModel(
        orderID: orderID,
        orderDate: orderDateWithTime,
        deliveryDate: orderDateWithTime.add(const Duration(days: 7)),
        products: listOfProductOrderModel,
        deliveredProducts: [],
        userID: user.uid!,
        name: paymentIntentModel.shippingModel.name,
        paymentID: paymentIntentModel.id,
        address: paymentIntentModel.shippingModel.addressModel.line1,
        pin: paymentIntentModel.shippingModel.addressModel.postalCode,
        city: paymentIntentModel.shippingModel.addressModel.city,
        state: paymentIntentModel.shippingModel.addressModel.state,
        country: paymentIntentModel.shippingModel.addressModel.country,
        currency: paymentIntentModel.currency,
        // shippingCharge: ,
        totalAmount: paymentIntentModel.amount,
      );
      final PaymentModel paymentModel = PaymentModel(
        userID: user.uid!,
        userName: user.username!,
        paymentID: paymentIntentModel.id,
      );
      print(9);
      await firebaseFirestore
          .collection('userOrders')
          .doc(user.uid!)
          .set(paymentModel.toJson());
      print(10);
      await firebaseFirestore
          .collection('userOrders')
          .doc(user.uid!)
          .collection('orderDetails')
          .doc(orderID)
          .set(orderModel.toJson());

      return 'success';
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AddressDetailsModel>> getAllUserAddress(
      {required String userID}) async {
    try {
      @override
      final snapshot = await firebaseFirestore
          .collection('userAddresses')
          .doc(userID)
          .collection('addresses')
          .get();
      return snapshot.docs
          .map((doc) => AddressDetailsModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> saveUserAddress(
      {required String address,
      required String pin,
      required String city,
      required String state,
      required String country}) async {
    try {
      const uuid = Uuid();
      final addressID = uuid.v4();

      final addressDetailsModel = AddressDetailsModel(
        addressID: addressID,
        city: city,
        country: country,
        line1: address,
        postalCode: pin,
        state: state,
      );

      final user = firebaseAuth.currentUser;
      if (user != null) {
        await firebaseFirestore
            .collection('userAddresses')
            .doc(user.uid)
            .collection('addresses')
            .doc(addressID)
            .set(addressDetailsModel.toJson());
      }
    } on FirebaseException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
