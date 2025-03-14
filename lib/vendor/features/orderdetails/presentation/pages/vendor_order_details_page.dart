import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/custom_app_bar.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/entities/order.dart' as model;
import 'package:tech_haven/core/entities/product_order.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/vendor/features/orderdetails/presentation/bloc/vendor_order_details_bloc.dart';

class VendorOrderDetailsPage extends StatelessWidget {
  const VendorOrderDetailsPage({super.key, required this.order});

  // final List<ProductOrderModel> products;
  final model.Order order;
  @override
  Widget build(BuildContext context) {
    List<ProductOrder> products = order.products;
    context
        .read<VendorOrderDetailsBloc>()
        .add(GetAllOrderedProductsEvent(listOfOrderModel: products));
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Order Products Details',
      ),
      body: SafeArea(
          child: BlocConsumer<VendorOrderDetailsBloc, VendorOrderDetailsState>(
        listener: (context, state) {
          if (state is GetAllOrderedProductsFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          if (state is GetAllOrderedProductsSuccess) {
            // print(state.listOfProducts.length);
            // print(products.length == 2);
            // print(state.listOfProducts.length);
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  height: 10,
                );
              },
              itemCount: state.listOfProducts.length,
              itemBuilder: (context, listIndex) {
                // print(index);
                // final currentProduct = products[index];
                // print(currentProduct.productID ==
                //     state.listOfProducts[index].productID);
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    decoration: const BoxDecoration(
                      color: AppPallete.darkgreyColor,
                    ),
                    //the whole container column
                    child: Column(
                      children: [
                        //row for the first bar
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //clock icon
                            const Row(
                              children: [
                                SvgIcon(
                                  icon: CustomIcons.clockSvg,
                                  radius: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                //column for the text
                                Column(
                                  children: [
                                    Text(
                                      'Status',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    // Text(
                                    //   '',
                                    //   style: TextStyle(
                                    //     fontSize: 12,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            //text for the amount
                            const Text('Not Delivered'),
                            Text(
                              'Total Price ${calculateTotalProductsPrize(amount: products[listIndex].price, quantity: products[listIndex].quantity) + products[listIndex].shippingCharge}',
                              style: const TextStyle(
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                        //divider
                        const Divider(),
                        //text for the order details
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GlobalTitleText(
                                title: 'Order Details',
                                fontSize: 16,
                              ),
                            ),
                            //row for the pic and details
                            Row(
                              children: [
                                //for the image container
                                Container(
                                  height: 100,
                                  width: 100,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: const BoxDecoration(
                                      color: AppPallete.whiteColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          5,
                                        ),
                                      ),
                                      boxShadow: [
                                        Constants.globalBoxBlur,
                                      ]),
                                  child: Image.network(
                                    fit: BoxFit.contain,
                                    state.listOfProducts[listIndex]
                                        .displayImageURL,
                                    scale: 10,
                                  ),
                                ),
                                //column for the details of the customer
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //row for the name and quantity of the product ordered
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Quantity : ${products[listIndex].quantity} '),
                                          ],
                                        ),
                                        //text customer details
                                        const GlobalTitleText(
                                          title: 'Product Details',
                                          fontSize: 14,
                                        ),
                                        Text(
                                            'Name :  ${state.listOfProducts[listIndex].name} '),
                                        Text(
                                            'Brand : ${state.listOfProducts[listIndex].brandName} '),
                                        Text(
                                          'Shipping fees : ${state.listOfProducts[listIndex].shippingCharge}',
                                          overflow: TextOverflow.fade,
                                        ),
                                        //accept button
                                        const GlobalTitleText(
                                          title: 'Amount Details',
                                          fontSize: 14,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'AED ${state.listOfProducts[listIndex].prize}'
                                              "x"
                                              '${products[listIndex].quantity}'
                                              '='
                                              '${calculateTotalProductsPrize(amount: products[listIndex].price, quantity: products[listIndex].quantity)}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),

                                            // const Text('+'),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'AED ${state.listOfProducts[listIndex].shippingCharge}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            // const Text('+'),
                                          ],
                                        ),
                                        Container(
                                          color: AppPallete.blackColor,
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.pending_actions,
                                              size: 16,
                                            ),
                                            Text(
                                              formatDateTime(
                                                  order.deliveryDate),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // column for the two buttons
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.end,
                                //   children: [

                                //   ],
                                // )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }

  double calculateTotalProductsPrize(
      {required num amount, required num quantity}) {
    return (quantity * amount).toDouble();
  }
}
