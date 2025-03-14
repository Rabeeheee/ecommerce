import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/custom_drop_down.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/entities/address_details.dart';
import 'package:tech_haven/user/features/checkout/data/models/address_model.dart';
import 'package:tech_haven/user/features/checkout/data/models/card_options_model.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_method_options_model.dart';
import 'package:tech_haven/user/features/checkout/data/models/shipping_model.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';
// import 'package:razorpay_web/razorpay_web.dart';

class ShippingDetailsPage extends StatefulWidget {
  const ShippingDetailsPage({super.key, required this.totalAmount});

  final String totalAmount;

  @override
  State<ShippingDetailsPage> createState() => _ShippingDetailsPageState();
}

class _ShippingDetailsPageState extends State<ShippingDetailsPage> {
  late TextEditingController addressController;
  late TextEditingController pinController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;
  late TextEditingController currencyController;
  late TextEditingController amountController;
  TextEditingController addressSearchEditingController =
      TextEditingController();
  AddressDetails? selectedAddress;
  List<String> stringAddresses = [];

  // late Razorpay razorPay;

  // void openCheckout() async {
  //   var amount = double.parse(widget.totalAmount) * 100;
  //   var options = {
  //     'key': 'rzp_test_1bzNTRLrpTxKeU',
  //     'amount': amount,
  //     'name': 'Rayid',
  //     'prefill': {
  //       // 'contact': 'contactController.text',
  //       'email': 'example@gmail.com'
  //     },
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };
  //   try {
  //     razorPay.open(options);
  //   } catch (e) {
  //     debugPrint('error: $e');
  //   }
  // }

  // void handlePaymentSuccess(PaymentSuccessResponse response) {
  //   try {
  //     double totalAmount = double.parse(widget.totalAmount);
  //     int amountInCents = (totalAmount * 100).toInt();

  //     PaymentIntentModel paymentIntentModel = PaymentIntentModel(
  //       id: response.paymentId!,
  //       amount: amountInCents,
  //       currency: 'INR',
  //       clientSecret: 'clientSecret',
  //       description: 'description',
  //       paymentMethodOptionsModel: PaymentMethodOptionsModel(
  //         cardOptionsModel:
  //             CardOptionsModel(requestThreeDSecure: 'requestThreeDSecure'),
  //       ),
  //       shippingModel: ShippingModel(
  //         addressModel: AddressModel(
  //           city: cityController.text,
  //           country: countryController.text,
  //           line1: addressController.text,
  //           postalCode: pinController.text,
  //           state: stateController.text,
  //         ),
  //         name: 'Rayid',
  //       ),
  //     );

  //     context
  //         .read<CheckoutBloc>()
  //         .add(SaveOrderEvent(paymentIntentModel: paymentIntentModel));

  //     Fluttertoast.showToast(
  //       msg: "Payment Successful ${response.paymentId!}",
  //       toastLength: Toast.LENGTH_SHORT,
  //     );
  //   } catch (e) {
  //     // print('Error handling payment success: $e');
  //     Fluttertoast.showToast(msg: 'Error handling payment success');
  //   }
  // }

  // void handlePaymentError(PaymentFailureResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "Payment Failed ${response.message!}",
  //       toastLength: Toast.LENGTH_SHORT);
  //   GoRouter.of(context).pop();
  // }

  // void handleExternalWallet(ExternalWalletResponse response) {
  //   Fluttertoast.showToast(
  //     msg: "External Wallet ${response.walletName!}",
  //     toastLength: Toast.LENGTH_SHORT,
  //   );
  //   GoRouter.of(context).pop();
  // }

  // @override
  // void dispose() {
  //   if (kIsWeb) {
  //     razorPay.clear();
  //   }
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   if (kIsWeb) {
  //     razorPay = Razorpay();
  //     razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
  //     razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
  //     razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  //   }
  //   addressController = TextEditingController();
  //   pinController = TextEditingController();
  //   cityController = TextEditingController();
  //   stateController = TextEditingController();
  //   countryController = TextEditingController();
  //   currencyController = TextEditingController();
  //   amountController = TextEditingController();
  //   currencyController.text = 'aed';
  //   amountController.text = '${widget.totalAmount}0';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // final formKey = GlobalKey<FormState>();
    // void submitForm() {
    //   if (formKey.currentState!.validate()) {
    //     formKey.currentState!.save();
    //     //save the address
    //     if (selectedAddress == null &&
    //         !stringAddresses.contains(addressController.text)) {
    //       context.read<CheckoutBloc>().add(SaveUserAddressEvent(
    //           address: addressController.text,
    //           pin: pinController.text,
    //           city: cityController.text,
    //           state: stateController.text,
    //           country: countryController.text));
    //     } else {
    //       if (stringAddresses.contains(addressController.text)) {
    //         Fluttertoast.showToast(
    //           msg:
    //               'This Address will not be saved for future purposes as It Already exists',
    //         );
    //       }
    //     }
    //     if (kIsWeb) {
    //       openCheckout();
    //     } else {
    //       context.read<CheckoutBloc>().add(SubmitPaymentFormEvent(
    //             address: addressController.text,
    //             pin: pinController.text,
    //             city: cityController.text,
    //             state: stateController.text,
    //             country: countryController.text,
    //             currency: currencyController.text,
    //             amount: (amountController.text.isNotEmpty)
    //                 ? (double.parse(amountController.text) * 100)
    //                     .toInt()
    //                     .toString()
    //                 : '0',
    //           ));
    //     }
    //   }
    // }

    // return Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Form(
    //       key: formKey,
    //       child: BlocConsumer<CheckoutBloc, CheckoutState>(
    //         listener: (context, state) {
    //           if (state is SaveUserAddressFailed) {
    //             Fluttertoast.showToast(msg: state.message);
    //           }
    //           if (state is SaveUserAddressSuccess) {
    //             Fluttertoast.showToast(
    //                 msg: 'New Location is added successfully');
    //           }
    //           if (state is AddressFailed) {
    //             Fluttertoast.showToast(msg: "You don't have saved address yet");
    //           }
    //         },
    //         builder: (context, addressLoadState) {
    //           return SingleChildScrollView(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const Text(
    //                   "Please enter your shipping details below. If you've previously saved addresses, you can select one from the dropdown menu.",
    //                   style: TextStyle(fontSize: 16.0),
    //                 ),
    //                 const SizedBox(height: 16.0),
    //                 if (addressLoadState is AddressLoaded)
    //                   BlocBuilder<CheckoutBloc, CheckoutState>(
    //                     buildWhen: (previous, current) =>
    //                         current is GetAllUserAddressState,
    //                     builder: (context, state) {
    //                       stringAddresses = addressLoadState.addresses
    //                           .map((e) => e.line1)
    //                           .toList();
    //                       stringAddresses.add('UnSelect Location');
    //                       return CustomDropDown<String>(
    //                           searchEditingController:
    //                               addressSearchEditingController,
    //                           hintText: 'Select Address',
    //                           items: stringAddresses,
    //                           currentItem: selectedAddress?.line1,
    //                           onChanged: (selectedAddress) {
    //                             setState(() {
    //                               if (selectedAddress != null &&
    //                                   addressLoadState.addresses
    //                                       .map((e) => e.line1)
    //                                       .contains(selectedAddress)) {
    //                                 this.selectedAddress = addressLoadState
    //                                     .addresses
    //                                     .firstWhere((element) =>
    //                                         element.line1 == selectedAddress);
    //                                 addressController.text =
    //                                     this.selectedAddress!.line1;
    //                                 pinController.text =
    //                                     this.selectedAddress!.postalCode;
    //                                 cityController.text =
    //                                     this.selectedAddress!.city;
    //                                 stateController.text =
    //                                     this.selectedAddress!.state;
    //                                 countryController.text =
    //                                     this.selectedAddress!.country;
    //                               } else {
    //                                 addressController.clear();
    //                                 pinController.clear();
    //                                 cityController.clear();
    //                                 stateController.clear();
    //                                 countryController.clear();
    //                                 this.selectedAddress = null;
    //                               }
    //                             });
    //                           });
    //                       return Container();
    //                     },
    //                   ),
    //                 const SizedBox(height: 8.0),
    //                 CustomTextFormField(
    //                   enabled: selectedAddress == null,
    //                   labelText: 'Address',
    //                   hintText: 'Enter Your Address',
    //                   textEditingController: addressController,
    //                 ),
    //                 CustomTextFormField(
    //                   enabled: selectedAddress == null,
    //                   labelText: 'Country',
    //                   hintText: 'Enter Your Country',
    //                   textEditingController: countryController,
    //                 ),
    //                 CustomTextFormField(
    //                   enabled: selectedAddress == null,
    //                   labelText: 'State',
    //                   hintText: 'Enter Your State',
    //                   textEditingController: stateController,
    //                 ),
    //                 CustomTextFormField(
    //                   enabled: selectedAddress == null,
    //                   labelText: 'City',
    //                   hintText: 'Enter Your City',
    //                   textEditingController: cityController,
    //                 ),
    //                 CustomTextFormField(
    //                   enabled: selectedAddress == null,
    //                   labelText: 'PIN',
    //                   hintText: 'Enter Your PIN',
    //                   keyboardType: TextInputType.number,
    //                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    //                   textEditingController: pinController,
    //                 ),
    //                 CustomTextFormField(
    //                   enabled: false,
    //                   labelText: 'Currency',
    //                   hintText: 'Enter Your Currency',
    //                   textEditingController: currencyController,
    //                 ),
    //                 CustomTextFormField(
    //                   enabled: false,
    //                   labelText: 'Total Amount',
    //                   hintText: 'Enter Your Amount',
    //                   textEditingController: amountController,
    //                 ),
    //                 const SizedBox(height: 16.0),
    //                 Center(
    //                   child: RoundedRectangularButton(
    //                     onPressed: submitForm,
    //                     title: 'Continue',
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }
}
