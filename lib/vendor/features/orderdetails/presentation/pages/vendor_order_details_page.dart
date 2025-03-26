import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/custom_app_bar.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/entities/order.dart' as model;
import 'package:tech_haven/core/entities/product_order.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/vendor/features/orderdetails/presentation/bloc/vendor_order_details_bloc.dart';

class VendorOrderDetailsPage extends StatelessWidget {
  const VendorOrderDetailsPage({super.key, required this.order});

  final model.Order order;

  @override
  Widget build(BuildContext context) {
    List<ProductOrder> products = order.products;
    context
        .read<VendorOrderDetailsBloc>()
        .add(GetAllOrderedProductsEvent(listOfOrderModel: products));

    return Scaffold(
      backgroundColor: Colors.white,
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
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                separatorBuilder: (context, index) => const SizedBox(height: 15),
                itemCount: state.listOfProducts.length,
                itemBuilder: (context, listIndex) {
                  return _buildProductDetailCard(
                    context, 
                    products[listIndex], 
                    state.listOfProducts[listIndex],
                    order
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductDetailCard(
    BuildContext context, 
    ProductOrder productOrder, 
    dynamic product,
    model.Order order
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12, width: 0.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
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
                    Text(
                      'Not Delivered',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Total: ${calculateTotalProductsPrize(amount: productOrder.price, quantity: productOrder.quantity) + productOrder.shippingCharge} AED',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.black12, height: 1),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Image.network(
                    product.displayImageURL,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => 
                      const Center(child: Icon(Icons.image_not_supported, color: Colors.black54)),
                  ),
                ),

                // Product Details Column
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quantity and Product Name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quantity: ${productOrder.quantity}',
                              style: const TextStyle(color: Colors.black87),
                            ),
                            Text(
                              'Brand: ${product.brandName}',
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Product Name
                        Text(
                          'Product: ${product.name}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Price Breakdown
                        _buildPriceBreakdown(productOrder, product),

                        // Delivery Date
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, 
                              size: 16, 
                              color: Colors.black54
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Delivery: ${formatDateTime(order.deliveryDate)}',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown(ProductOrder productOrder, dynamic product) {
    final productTotal = calculateTotalProductsPrize(
      amount: productOrder.price, 
      quantity: productOrder.quantity
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Price: ',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: '${product.prize} AED x ${productOrder.quantity} = $productTotal AED',
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Shipping: ',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: '${product.shippingCharge} AED',
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double calculateTotalProductsPrize({
    required num amount, 
    required num quantity
  }) {
    return (quantity * amount).toDouble();
  }
}