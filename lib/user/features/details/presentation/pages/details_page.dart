import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_page_divider.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/bottom_cart_quantity_and_button.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/details_grid_view_list_widget.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/overview_and_sprecification_tab_bar.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/product_brand_and_title.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/product_images_display_widget.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/user_review_container_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //for the main products logic this is

      // context.read<DetailsPageBloc>().add(EmitInitialFavoriteButtonState());
      context
          .read<DetailsPageBloc>()
          .add(GetAllImagesForProductEvent(productID: product.productID));
      context
          .read<DetailsPageBloc>()
          .add(GetProductCartDetailsEvent(productID: product.productID));
      // for the related products

      context
          .read<DetailsPageBloc>()
          .add(GetAllBrandRelatedProductsDetailsEvent(product: product));
      print('hello');
      print('hi');
      context.read<DetailsPageBloc>().add(GetProductFavoriteDetailsEvent());
      print('ho');
      // print('next is getting all brand related cart details');
      print('all the brand related product is gotten');
    });

    context
        .read<DetailsPageBloc>()
        .add(GetAllReviewOfProductEvent(productID: product.productID));
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarSearchBar(
          backButton: true,
          deliveryPlaceNeeded: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //for the brand name
              ProductBrandAndTitle(product: product),
              const SizedBox(
                height: 25,
              ),
              ProductImagesDisplayWidget(
                product: product,
              ),
      
              //for the indicator
      
              Container(),
      
              //for the prize tag
              SizedBox(
                height: 250,
                child: OverviewAndSpecificationTabBar(
                  overview: product.overview,
                  specifications: product.specifications ?? {},
                ),
              ),
              const GlobalPageDivider(),
              Padding(
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
              ),
              // Container(
              //   color: AppPallete.whiteColor,
              //   height: 150,
              //   width: double.infinity,
              //   child: const Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 10,
              //           vertical: 5,
              //         ),
              //         child: GlobalTitleText(
              //           title: 'Available Colors',
              //         ),
              //       ),
              //       // AvailableColorHorizontalListView(product: product),
              //     ],
              //   ),
              // ),
              const GlobalPageDivider(),
      
              UserReviewContainerWidget(
                product: product,
              ),
      
              Container(
                // height: 600,
                padding: const EdgeInsets.all(10),
                child: GlobalTitleText(
                  title: 'More From ${product.brandName}',
                  fontSize: 16,
                  color: AppPallete.primaryAppColor,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              DetailsGridViewListWidget(
                product: product,
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
        bottomSheet: BottomCartQuantityAndButton(product: product),
      ),
    );
  }
}
