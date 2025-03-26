import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
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
          Fluttertoast.showToast(
              msg: 'The Product Is Updated To Cart Successfully');
          context.read<DetailsPageBloc>().add(
              GetProductCartDetailsEvent(productID: product.productID));
        }
        if (state is UpdateProductToCartDetailsFailed) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      buildWhen: (previous, current) => current is CartDetailsState,
      builder: (context, state) {
        if (state is CartLoadedSuccessDetailsState) {
          bool productIsCarted = state.cart.cartID != 'null';
          int productCount = state.cart.productCount < 0 ? 0 : state.cart.productCount;

          return Container(
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
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.fromBorderSide(
                      BorderSide(color: AppPallete.greyTextColor, width: 0.5),
                    ),
                  ),
                  child: InkWell(
                    onTap: product.quantity <= 0 
                      ? () {
                          showSnackBar(
                            context: context,
                            title: 'Out of Stock',
                            content: 'This product is currently unavailable.',
                            contentType: ContentType.failure,
                          );
                        }
                      : () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController controller =
                                TextEditingController(text: productCount.toString());
                            return AlertDialog(
                              title: const Text('Update Quantity'),
                              content: CustomTextFormField(
                                textEditingController: controller,
                                labelText:
                                    'Total Quantity Available: ${product.quantity.toString()}',
                                hintText: 'Enter a value',
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              ),
                              actions: <Widget>[
                                RoundedRectangularButton(
                                  title: 'Cancel',
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                RoundedRectangularButton(
                                  onPressed: () {
                                    int newQuantity = int.tryParse(controller.text) ?? 0;
                                    if (newQuantity > product.quantity) {
                                      showSnackBar(
                                        context: context,
                                        title: 'Quantity Error',
                                        content: 'There is not enough stock available.',
                                        contentType: ContentType.failure,
                                      );
                                    } else {
                                      context.read<DetailsPageBloc>().add(
                                          UpdateProductToCartDetailsEvent(
                                              cart: productIsCarted ? state.cart : null,
                                              itemCount: newQuantity >= 0 ? newQuantity : 0,
                                              product: product));
                                      Navigator.of(context).pop();
                                    }
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
                        const Text('QTY',
                            style: TextStyle(
                                color: AppPallete.greyTextColor, fontSize: 10)),
                        Text(
                          productCount.toString(),
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
                const SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: RoundedRectangularButton(
                      title: productIsCarted && productCount >= 1
                          ? 'REMOVE FROM CART'
                          : 'ADD TO CART',
                      onPressed: product.quantity <= 0 
                        ? () {
                            showSnackBar(
                              context: context,
                              title: 'Out of Stock',
                              content: 'This product is currently unavailable.',
                              contentType: ContentType.failure,
                            );
                          }
                        : () {
                        context.read<DetailsPageBloc>().add(
                          UpdateProductToCartDetailsEvent(
                            cart: productIsCarted ? state.cart : null,
                            itemCount: productIsCarted ? 0 : 1,
                            product: product,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
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
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.fromBorderSide(
                    BorderSide(color: AppPallete.greyTextColor, width: 0.5),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('QTY',
                        style: TextStyle(
                            color: AppPallete.greyTextColor, fontSize: 10)),
                    Text('0',
                        style: TextStyle(
                          color: AppPallete.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: SizedBox(
                  height: 50, 
                  child: RoundedRectangularButton(
                    title: 'ADD TO CART', 
                    onPressed: () {
                      showSnackBar(
                        context: context,
                        title: 'Out of Stock',
                        content: 'This product is currently unavailable.',
                        contentType: ContentType.failure,
                      );
                    }
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