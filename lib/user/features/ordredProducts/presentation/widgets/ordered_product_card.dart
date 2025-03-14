import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/entities/user_ordered_product.dart';

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
                child: CachedNetworkImage(
                  imageUrl: widget.product.displayImageURL,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade100,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover, // Adjust this based on your requirement
                )),
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
