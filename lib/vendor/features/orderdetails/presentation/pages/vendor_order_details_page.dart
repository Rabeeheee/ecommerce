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
    context.read<VendorOrderDetailsBloc>().add(GetAllOrderedProductsEvent(listOfOrderModel: products));

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CustomAppBar(title: 'Order Details'),
      body: SafeArea(
        child: BlocConsumer<VendorOrderDetailsBloc, VendorOrderDetailsState>(
          listener: (context, state) {
            if (state is GetAllOrderedProductsFailed) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          builder: (context, state) {
            if (state is GetAllOrderedProductsSuccess) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.listOfProducts.length,
                itemBuilder: (context, index) {
                  return _buildProductDetailCard(
                    context, 
                    products[index], 
                    state.listOfProducts[index], 
                    order,
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator(color: Colors.black));
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SvgIcon(icon: CustomIcons.clockSvg, radius: 20, color: Colors.black54),
                    const SizedBox(width: 8),
                    Text('Not Delivered', style: TextStyle(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500)),
                  ],
                ),
                Text(
                  '${calculateTotalProductsPrize(amount: productOrder.price, quantity: productOrder.quantity) + productOrder.shippingCharge} AED',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1, color: Colors.black12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.displayImageURL,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, color: Colors.black54, size: 50),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product: ${product.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('Brand: ${product.brandName}', style: const TextStyle(color: Colors.black87)),
                      const SizedBox(height: 4),
                      Text('Quantity: ${productOrder.quantity}', style: const TextStyle(color: Colors.black87)),
                      const SizedBox(height: 4),
                      Text('Delivery: ${formatDateTime(order.deliveryDate)}', style: const TextStyle(color: Colors.black87)),
                      const SizedBox(height: 10),
                      _buildPriceBreakdown(productOrder, product),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown(ProductOrder productOrder, dynamic product) {
    final productTotal = calculateTotalProductsPrize(amount: productOrder.price, quantity: productOrder.quantity);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Price: ${product.prize} AED x ${productOrder.quantity} = $productTotal AED', style: const TextStyle(color: Colors.black87)),
        const SizedBox(height: 4),
        Text('Shipping: ${product.shippingCharge} AED', style: const TextStyle(color: Colors.black87)),
      ],
    );
  }

  double calculateTotalProductsPrize({required num amount, required num quantity}) {
    return (quantity * amount).toDouble();
  }
}
