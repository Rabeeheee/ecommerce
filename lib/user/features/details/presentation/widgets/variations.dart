import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/utils/sum.dart';

class Variations extends StatelessWidget {
  const Variations({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Color: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                ':',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                product.color,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors
                      .blue, // You can choose any color you prefer
                ),
              ),
            ],
          ),
          
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                const Icon(Icons.radio_button_checked,
                    color: Colors.blue),
                const SizedBox(width: 8.0),
                const Text(
                  'Exchange & Save',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  'upto AED ${(product.oldPrize - product.prize).floor()}',
                  style: const TextStyle(color: Colors.orange),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Without Exchange',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Text(
                '-${calculateDiscountPercentage(product.oldPrize, product.prize)}%',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                'AED ${product.prize}',
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            'List Price: AED ${product.oldPrize}',
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'FREE Returns',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text('All prices include VAT.'),
          Text(
              'FREE delivery ${DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 7)))}, ${formatDateTime(DateTime.now().add(const Duration(days: 7)))}'),
          const SizedBox(height: 8.0),
          
          // RichText(
          //   text: const TextSpan(
          //     children: [
          //       TextSpan(
          //         text: 'Or fastest delivery ',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       TextSpan(
          //         text: 'Tomorrow, 26 June. ',
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       TextSpan(
          //         text: 'Order within ',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       TextSpan(
          //         text: '5 hrs 37 mins',
          //         style: TextStyle(color: Colors.green),
          //       ),
          //     ],
          //   ),
          // ),
          // const Text(
          //   'Delivering to Dubai - Update location',
          //   style: TextStyle(
          //     color: Colors.blue,
          //   ),
          // ),
          const SizedBox(height: 8.0),
          Text(
            product.quantity <= 0 ? 'Not In Stock' : 'In Stock',
            style: TextStyle(
              color: product.quantity <= 0 ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
