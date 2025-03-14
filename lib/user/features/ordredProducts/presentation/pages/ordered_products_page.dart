import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/entities/user_ordered_product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/ordredProducts/presentation/bloc/ordered_products_page_bloc.dart';

class OrderedProductsPage extends StatelessWidget {
  final String orderID;

  const OrderedProductsPage({super.key, required this.orderID});

  @override
  Widget build(BuildContext context) {
    // print(orderID);
    context
        .read<OrderedProductsPageBloc>()
        .add(FetchOrderProductsEvent(orderId: orderID));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: const CustomBackButton(),
        backgroundColor: AppPallete.whiteColor,
      ),
      body: BlocBuilder<OrderedProductsPageBloc, OrderedProductsPageState>(
        builder: (context, state) {
          if (state is OrderedProductsPageLoading) {
            return const Loader();
          } else if (state is OrderedProductsPageError) {
            return Center(child: Text(state.message));
          } else if (state is OrderedProductsPageLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return OrderedProductCard(product: products[index]);
              },
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}

class OrderedProductCard extends StatefulWidget {
  final UserOrderedProduct product;

  const OrderedProductCard({super.key, required this.product});

  @override
  State<OrderedProductCard> createState() => _OrderedProductCardState();
}

class _OrderedProductCardState extends State<OrderedProductCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              child: Image.network(
                widget.product.displayImageURL,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${widget.product.prize.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.product.oldPrize > widget.product.prize)
              Text(
                '\$${widget.product.oldPrize.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            const SizedBox(height: 10),
            Text('Quantity: ${widget.product.quantity}'),
            Text('Brand: ${widget.product.brandName}'),
            Text('Vendor: ${widget.product.vendorName}'),
            Text('Category: ${widget.product.mainCategory}'),
            if (widget.product.subCategory.isNotEmpty)
              Text('Subcategory: ${widget.product.subCategory}'),
            Text('Variant: ${widget.product.variantCategory}'),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Specifications:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...widget.product.specifications.entries.map((entry) {
                  return Text('${entry.key}: ${entry.value}');
                }),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Overview:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              _isExpanded
                  ? widget.product.overview
                  : widget.product.overview.length > 100
                      ? '${widget.product.overview.substring(0, 100)}...'
                      : widget.product.overview,
              style: TextStyle(color: Colors.grey[600]),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? 'Read less' : 'Read more',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
