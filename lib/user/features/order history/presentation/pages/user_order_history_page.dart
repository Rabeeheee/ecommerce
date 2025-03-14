import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/order%20history/presentation/bloc/user_order_history_page_bloc.dart';

class UserOrderHistoryPage extends StatelessWidget {
  const UserOrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserOrderHistoryPageBloc>().add(GetUserOrderHistoryEvent());
    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: AppPallete.whiteColor,
          automaticallyImplyLeading: false,
          leading: const CustomBackButton(),
          title: const Text('Your Order History'),
          centerTitle: true,
        ),
        body: BlocBuilder<UserOrderHistoryPageBloc, UserOrderHistoryState>(
          builder: (context, state) {
            if (state is UserOrderHistoryInitial) {
              return const Center(child: Text('Welcome!'));
            } else if (state is UserOrderHistoryLoading) {
              return const Loader();
            } else if (state is UserOrderHistoryLoaded) {
              if (state.orders.isEmpty) {
                return const Center(
                  child: Text(
                      "You haven't bought anything so far from this store"),
                );
              }
              return Container(
                  alignment: Alignment.topCenter,
                  child: Accordion(
                    headerBorderRadius: 10,
                    maxOpenSections: 1,
                    headerBackgroundColorOpened: Colors.blue,
                    scaleWhenAnimating: true,
                    openAndCloseAnimation: true,
                    children: state.orders.map((order) {
                      return AccordionSection(
                          isOpen: false,
                          header: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Ordered Date',
                                    style: TextStyle(
                                      color: AppPallete.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    formatDateTime(order.orderDate),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Delivered Date',
                                    style: TextStyle(
                                      color: AppPallete.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    formatDateTime(order.deliveryDate),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Total Amount',
                                    style: TextStyle(
                                      color: AppPallete.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'AED ${changeAmountDecimal(amount: order.totalAmount)}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 2, 255, 10),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order Details',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ListTile(
                                      leading: const Icon(Icons.shopping_cart),
                                      title: const Text('Total Items'),
                                      trailing:
                                          Text('${order.products.length}'),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      leading: const Icon(Icons.account_circle),
                                      title: const Text('Name'),
                                      trailing: Text(order.name),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.home),
                                      title: const Text('Address'),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(order.address),
                                          Text(
                                              '${order.city}, ${order.state}, ${order.country}'),
                                          Text('Pin: ${order.pin}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RoundedRectangularButton(
                                title: 'Show Product Details',
                                onPressed: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRouteConstants.orderedProductsPage,
                                      pathParameters: {
                                        'orderID': order.orderID
                                      });
                                },
                              )
                            ],
                          ));
                    }).toList(),
                  ));
            } else if (state is UserOrderHistoryError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Container();
            }
          },
        ));
  }
}

// class ProductDetailsWidget extends StatelessWidget {
//   final UserOrderedProduct product;

//   const ProductDetailsWidget({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(10.0),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(product.displayImageURL),
//             const SizedBox(height: 10.0),
//             Text('Product Name: ${product.name}',
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text('Quanity Bought: ${product.quantity}'),
//             Text('Brand: ${product.brandName}'),
//             Text('Category: ${product.mainCategory}'),
//             Text('Sub-Category: ${product.subCategory}'),
//             Text('Price: AED \$${product.prize.toStringAsFixed(2)}'),
//             Text('Old Price: \$${product.oldPrize.toStringAsFixed(2)}'),
//             Text(
//                 'Shipping Charge: \$${product.shippingCharge.toStringAsFixed(2)}'),
//             Text('Vendor: ${product.vendorName}'),
//             Text('Overview: ${product.overview}'),
//             // Text('Order ID: ${product.orderID}'),
//             // Text('Product ID: ${product.productID}'),
//             Text('Ordered Date: ${formatDateTime(product.dateTime)}'),
//             const SizedBox(height: 10.0),
//             // const Text('Specifications:',
//             //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             ...product.specifications.entries.map((entry) {
//               return Text('${entry.key}: ${entry.value}');
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class OrdersList extends StatelessWidget {
//   final List<OrderModel> orders;

//   const OrdersList({super.key, required this.orders});

//   @override
//   Widget build(BuildContext context) {
//     print(orders[0].orderID);
//     return 
//   }
// }
