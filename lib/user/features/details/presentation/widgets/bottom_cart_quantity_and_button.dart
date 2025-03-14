import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';

class BottomCartQuantityAndButton extends StatelessWidget {
  const BottomCartQuantityAndButton({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsPageBloc, DetailsPageState>(
      listener: (context, state) {
        if (state is UpdateProductToCartDetailsSuccess) {
          // print('hello how are you hope you are doing good');
          Fluttertoast.showToast(
              msg: 'The Product Is Updated To Cart SuccessFully');
          context
              .read<DetailsPageBloc>()
              .add(GetProductCartDetailsEvent(productID: product.productID));
        }
        if (state is UpdateProductToCartDetailsFailed) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      buildWhen: (previous, current) => current is CartDetailsState,
      builder: (context, state) {
        // print(state);
        if (state is CartLoadedSuccessDetailsState) {
          bool productIsCarted = false;
          if (state.cart.cartID != 'null') {
            productIsCarted = true;
          }

          return Container(
            // width: double.maxFinite,
            height: 70,
            decoration: const BoxDecoration(
              color: AppPallete.whiteColor,
              border: Border(
                top: BorderSide(
                  color: AppPallete.greyTextColor,
                  width: 0.5,
                ),
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: AppPallete.whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        5,
                      ),
                    ),
                    border: Border(
                      top: BorderSide(
                        color: AppPallete.greyTextColor,
                        width: 0.5,
                      ),
                      bottom: BorderSide(
                        color: AppPallete.greyTextColor,
                        width: 0.5,
                      ),
                      right: BorderSide(
                        color: AppPallete.greyTextColor,
                        width: 0.5,
                      ),
                      left: BorderSide(
                        color: AppPallete.greyTextColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController controller =
                              TextEditingController();

                          controller.text = state.cart.productCount.toString();
                          return AlertDialog(
                            title: const Text('Update Quantity'),
                            content: CustomTextFormField(
                              textEditingController: controller,
                              labelText:
                                  'Total Quantity Available : ${product.quantity.toString()}',
                              hintText: 'Enter a value',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            actions: <Widget>[
                              RoundedRectangularButton(
                                title: 'Cancel',
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                              RoundedRectangularButton(
                                onPressed: () {
                                  if (product.quantity >=
                                      int.parse(controller.text)) {
                                    // print('hello');
                                    productIsCarted
                                        ? context.read<DetailsPageBloc>().add(
                                            UpdateProductToCartDetailsEvent(
                                                cart: state.cart,
                                                itemCount:
                                                    int.parse(controller.text),
                                                product: product))
                                        : context.read<DetailsPageBloc>().add(
                                            UpdateProductToCartDetailsEvent(
                                                cart: null,
                                                itemCount:
                                                    int.parse(controller.text),
                                                product: product));
                                    // print('hello');
                                    Navigator.of(context).pop();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Insufficient Quantity availble for this product');
                                  }
                                  // Perform update logic here

                                  // String newValue = controller.text;
                                  // print('New value: $newValue');
                                  // Close the dialog
                                },
                                title: 'Update',
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'QTY',
                          style: TextStyle(
                              color: AppPallete.greyTextColor, fontSize: 10),
                        ),
                        Text(
                          state.cart.productCount.toString(),
                          style: const TextStyle(
                            color: AppPallete.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: RoundedRectangularButton(
                      title: !productIsCarted && state.cart.productCount == 1
                          ? 'ADD TO CART'
                          : productIsCarted && state.cart.productCount >= 1
                              ? 'REMOVE FROM CART'
                              : '',
                      onPressed: () {
                        productIsCarted
                            ? context.read<DetailsPageBloc>().add(
                                UpdateProductToCartDetailsEvent(
                                    cart: state.cart,
                                    itemCount: 0,
                                    product: product))
                            : context.read<DetailsPageBloc>().add(
                                UpdateProductToCartDetailsEvent(
                                    cart: null,
                                    itemCount: 1,
                                    product: product));
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          // width: double.maxFinite,
          height: 70,
          decoration: const BoxDecoration(
            color: AppPallete.whiteColor,
            border: Border(
              top: BorderSide(
                color: AppPallete.greyTextColor,
                width: 0.5,
              ),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: AppPallete.whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      5,
                    ),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: AppPallete.greyTextColor,
                      width: 0.5,
                    ),
                    bottom: BorderSide(
                      color: AppPallete.greyTextColor,
                      width: 0.5,
                    ),
                    right: BorderSide(
                      color: AppPallete.greyTextColor,
                      width: 0.5,
                    ),
                    left: BorderSide(
                      color: AppPallete.greyTextColor,
                      width: 0.5,
                    ),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'QTY',
                      style: TextStyle(
                          color: AppPallete.greyTextColor, fontSize: 10),
                    ),
                    Text(
                      '0',
                      style: TextStyle(
                        color: AppPallete.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Expanded(
                child: SizedBox(
                  height: 50,
                  child: RoundedRectangularButton(
                    title: 'ADD TO CART',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
