import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/delivery_date_change.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/small_long_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/entities/order.dart' as model;
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/sum.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(
      {super.key, required this.order, required this.onTap, required this.isUser, this.onPressedDeliverButton
      // required this.listOfProductsModel,
      });

  final void Function()? onPressedDeliverButton;
  // final List<Product> listOfProductsModel;
  final bool isUser;
  final model.Order order;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                Row(
                  children: [
                    const SvgIcon(
                      icon: CustomIcons.clockSvg,
                      radius: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //column for the text
                    Column(
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          formatDateTime(order.orderDate),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //text for the amount
                Column(
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      order.products.length == order.deliveredProducts.length
                          ? 'Waiting for Admin to Deliver \n the Products'
                          : '${order.products.length - order.deliveredProducts.length} product is on pending',
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
                Text(
                  'Total Amount \n${changeAmountDecimal(amount: order.totalAmount)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blue,
                    overflow: TextOverflow.fade,
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //row for the name and quantity of the product ordered
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('No of Items : ${order.products.length}'),
                              ],
                            ),
                            //text customer details
                            GlobalTitleText(
                              title: isUser
                                  ? 'Delivery Details'
                                  : 'Customer Details',
                              fontSize: 14,
                            ),
                            Text(
                              'Delivery Date : ${formatDateTime(order.deliveryDate)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(isUser
                                ? 'City : ${order.city}'
                                : 'Name : ${order.name}'),
                            Text('Location : ${order.address}'),
                            Text('State : ${order.state}'),
                            Text('Country : ${order.country}'),
                            Text(
                              isUser ? '' : 'Customer ID :${order.userID}',
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //column for the two buttons
                    if (!isUser)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //accept button
                          Text(
                            'Your Share : ${calculateTotalPrizeForVendorOrdrer(productOrderModel: order.products)}',
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          if (!isUser)
                            SmallLongButton(
                              onPressed: onPressedDeliverButton,
                              text: 'Deliver',
                              bgColor: Colors.green,
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          //decline button
                          // const Text(
                          //   'Date of Delivery',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //   ),
                          // ),
                          if (!isUser) DeliveryDateChange(order: order),
                          // SmallLongButton(
                          //   onPressed: () {},
                          //   text: 'Choose Date',
                          //   bgColor: Colors.red,
                          // )
                        ],
                      )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
