// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_web/razorpay_web.dart';
// import 'package:tech_haven/core/theme/app_pallete.dart';
// import 'package:tech_haven/user/features/checkout/data/models/address_model.dart';
// import 'package:tech_haven/user/features/checkout/data/models/card_options_model.dart';
// import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';
// import 'package:tech_haven/user/features/checkout/data/models/payment_method_options_model.dart';
// import 'package:tech_haven/user/features/checkout/data/models/shipping_model.dart';
// import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';

// class RazorPaymentPage extends StatefulWidget {
//   const RazorPaymentPage({super.key, required this.totalAmount});
//   final String totalAmount;

//   @override
//   State<RazorPaymentPage> createState() => _RazorPaymentPageState();
// }

// class _RazorPaymentPageState extends State<RazorPaymentPage> {
//   late Razorpay razorPay;
//   TextEditingController amtController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController contactController = TextEditingController();
//   TextEditingController emailController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   void openCheckout() async {
//     var amount = double.parse(widget.totalAmount) * 100;
//     var options = {
//       'key': 'rzp_test_1bzNTRLrpTxKeU',
//       'amount': amount,
//       'name': nameController.text,
//       'prefill': {
//         'contact': contactController.text,
//         'email': emailController.text
//       },
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//     try {
//       razorPay.open(options);
//     } catch (e) {
//       debugPrint('error: $e');
//     }
//   }

//   void handlePaymentSuccess(PaymentSuccessResponse response) {
//     PaymentIntentModel paymentIntentModel = PaymentIntentModel(
//         id: response.paymentId!,
//         amount: int.parse(widget.totalAmount) * 100,
//         currency: 'INR',
//         clientSecret: 'clientSecret',
//         description: 'description',
//         paymentMethodOptionsModel: PaymentMethodOptionsModel(
//             cardOptionsModel:
//                 CardOptionsModel(requestThreeDSecure: 'requestThreeDSecure')),
//         shippingModel: ShippingModel(
//             addressModel: AddressModel(
//                 city: 'city',
//                 country: 'country',
//                 line1: 'line1',
//                 postalCode: '123456',
//                 state: 'kerala'),
//             name: nameController.text));
//     context
//         .read<CheckoutBloc>()
//         .add(SaveOrderEvent(paymentIntentModel: paymentIntentModel));
//     Fluttertoast.showToast(
//         msg: "Payment Successful ${response.paymentId!}",
//         toastLength: Toast.LENGTH_SHORT);
//     print(response.orderId);
//   }

//   void handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(
//         msg: "Payment Failed ${response.message!}",
//         toastLength: Toast.LENGTH_SHORT);
//   }

//   void handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//       msg: "External Wallet ${response.walletName!}",
//       toastLength: Toast.LENGTH_SHORT,
//     );
//   }

//   @override
//   void dispose() {
//     razorPay.clear();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     razorPay = Razorpay();
//     razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
//     razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
//     razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppPallete.primaryAppButtonColor,
//       appBar: AppBar(
//         backgroundColor: AppPallete.primaryAppColor,
//         title: const Text('Payment Page'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 30),
//                 Center(
//                   child: Image.asset(
//                     'assets/logo/techHavenLogo.png',
//                     height: 100,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 Container(
//                   // elevation: 5,
//                   // shape: RoundedRectangleBorder(
//                   //   borderRadius: BorderRadius.circular(10),
//                   // ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         const Text(
//                           'Enter your details',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: AppPallete.primaryAppColor,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 20),
//                         TextFormField(
//                           controller: nameController,
//                           decoration: InputDecoration(
//                             labelText: 'Name',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your name';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 20),
//                         TextFormField(
//                           controller: contactController,
//                           decoration: InputDecoration(
//                             labelText: 'Contact',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your contact';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 20),
//                         TextFormField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 30),
//                         Center(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 openCheckout();
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppPallete.primaryAppColor,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 50,
//                                 vertical: 15,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: const Text(
//                               'Pay Now',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
