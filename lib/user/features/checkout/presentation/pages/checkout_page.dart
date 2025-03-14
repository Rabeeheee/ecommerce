import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:tech_haven/user/features/checkout/presentation/pages/shipping_details_page.dart';
import 'package:tech_haven/user/features/checkout/presentation/pages/submit_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.totalAmount});
  final String totalAmount;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PageController pageController = PageController();
  int currentstep = 0;

  @override
  Widget build(BuildContext context) {
    context.read<CheckoutBloc>().add(LoadAddresses());
    late PaymentIntentModel paymentIntentModel;
    // context.read<CheckoutBloc>().add(CheckoutInitialEmit());
    // print(context.read<CheckoutBloc>().state);

    return Scaffold(
      // Appbar
      appBar: const AppBarSearchBar(
        backButton: true,
        deliveryPlaceNeeded: false,
      ),
      // Body
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is SubmitPaymentFormFailed) {
            Fluttertoast.showToast(msg: state.message);
            GoRouter.of(context).pop();
          }
          if (state is SubmitPaymentFormSuccess) {
            // print(state);
            pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
            if (!kIsWeb) {
              // print('state is success');

              paymentIntentModel = state.paymentIntentModel;
              context.read<CheckoutBloc>().add(
                    ShowPresentPaymentSheetEvent(
                      paymentIntentModel: state.paymentIntentModel,
                    ),
                  );
            } else {
              // showPaymentSheetForWeb(
              //     paymentIntentModel: state.paymentIntentModel);
            }
          }
          if (state is PaymentFailed) {
            Fluttertoast.showToast(msg: state.message);
            GoRouter.of(context).pop();
          }
          if (state is PaymentSuccess) {
            // print('success');
            showSnackBar(
                context: context,
                title: 'Success',
                content: 'The Payment has successfully completed',
                contentType: ContentType.success);
            context.read<CheckoutBloc>().add(
                  SaveOrderEvent(
                    paymentIntentModel: state.paymentIntentModel,
                  ),
                );
          }
          if (state is SaveOrderFailed) {
            Fluttertoast.showToast(msg: state.message);
            context
                .read<CheckoutBloc>()
                .add(SaveOrderEvent(paymentIntentModel: paymentIntentModel));
            // GoRouter.of(context).pop();
          }
          if (state is SaveOrderSuccess) {
            // print('deleting cart');
            context
                .read<CheckoutBloc>()
                .add(RemoveAllProductsFromTheCartAndSendOrderEvent());
          }
          if (state is AllCartsClearedSuccessState) {
          
                GoRouter.of(context).pop();
              
          
          }
          if (state is AllCartClearedFailedState) {
            context
                .read<CheckoutBloc>()
                .add(RemoveAllProductsFromTheCartAndSendOrderEvent());
            Fluttertoast.showToast(msg: '${state.message}please wait');
          }
        },
        builder: (context, state) {
          if (state is SubmitPaymentFormSuccess) {
            currentstep = 1;
            return Column(
              children: [
                SizedBox(
                  // color: Colors.red,
                  height: 72,
                  child: Stepper(
                    elevation: 0,
                    currentStep: currentstep,
                    steps: const [
                      Step(
                        title: Text('Shipping'),
                        content: Text('World!'),
                        state: StepState.complete,
                        isActive: true,
                      ),
                      Step(
                        title: Text('Submit'),
                        content: Text('Hello World!'),
                        state: StepState.indexed,
                        isActive: true,
                      ),
                    ],
                    type: StepperType.horizontal,
                    stepIconBuilder: (stepIndex, stepState) {
                      return null;
                    },
                    controlsBuilder: (context, details) {
                      return Container();
                    },
                    onStepTapped: (step) {
                    },
                    onStepContinue: () {},
                    onStepCancel: () {
                    },
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ShippingDetailsPage(
                        totalAmount: widget.totalAmount,
                      ),
                      const SubmitPage(),
                    ],
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              Container(
                color: Colors.red,
                height: 72,
                child: Stepper(
                  elevation: 0,
                  currentStep: currentstep,
                  steps: [
                    Step(
                      title: const Text('Shipping'),
                      content: const Text('World!'),
                      state: currentstep == 1
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: true,
                    ),
                    Step(
                      title: const Text('Submit'),
                      content: const Text('Hello World!'),
                      state: StepState.indexed,
                      isActive: currentstep == 1,
                    ),
                  ],
                  type: StepperType.horizontal,
                  stepIconBuilder: (stepIndex, stepState) {
                    return null;
                  },
                  controlsBuilder: (context, details) {
                    return Container();
                  },
                  onStepTapped: (step) {},
                  onStepContinue: () {},
                  onStepCancel: () {},
                ),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ShippingDetailsPage(
                      totalAmount: widget.totalAmount,
                    ),
                    const SubmitPage()
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // showPaymentSheetForWeb({required PaymentIntentModel paymentIntentModel}) {
  //   final String clientSecret = paymentIntentModel.clientSecret;
  //   final PlatformWebViewController controller = PlatformWebViewController(
  //     const PlatformWebViewControllerCreationParams(),
  //   )..loadRequest(
  //       LoadRequestParams(
  //         uri: Uri.parse(
  //             'https://techhavenstripepayment.web.app/?client_secret=$clientSecret'),
  //       ),
  //     );

  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       child: SizedBox(
  //         width: 400,
  //         height: 600,
  //         child: PlatformWebViewWidget(
  //           PlatformWebViewWidgetCreationParams(controller: controller),
  //         ).build(context),
  //       ),
  //     ),
  //   );
  // }
}
