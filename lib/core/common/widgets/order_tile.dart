import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/delivery_date_change.dart';
import 'package:tech_haven/core/common/widgets/small_long_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/entities/order.dart' as model;
import 'package:tech_haven/core/utils/sum.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key, 
    required this.order, 
    required this.onTap, 
    required this.isUser, 
    this.onPressedDeliverButton,
  });

  final void Function()? onPressedDeliverButton;
  final bool isUser;
  final model.Order order;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SvgIcon(
                      icon: CustomIcons.clockSvg,
                      radius: 20,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          formatDateTime(order.orderDate),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  changeAmountDecimal(amount: order.totalAmount),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const Divider(color: Colors.black12, thickness: 0.5),
            
            // Order Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Items: ${order.products.length}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isUser ? 'Delivery Details' : 'Customer Details',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Delivery Date: ${formatDateTime(order.deliveryDate)}',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        isUser 
                          ? 'City: ${order.city}' 
                          : 'Name: ${order.name}',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Location: ${order.address}',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isUser) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Your Share: ${calculateTotalPrizeForVendorOrdrer(productOrderModel: order.products)}',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SmallLongButton(
                        onPressed: onPressedDeliverButton,
                        text: 'Deliver',
                        bgColor: Colors.black,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      DeliveryDateChange(order: order),
                    ],
                  )
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}