import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/custom_blur_button.dart';
import 'package:tech_haven/core/common/widgets/custom_drop_down.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/common/widgets/product_card.dart';
// import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/user/features/search/presentation/bloc/search_page_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/brand_drop_down.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/drop_down_widgets.dart';
// import '../bloc/product_search_bloc.dart';
// import '../bloc/product_search_event.dart';
// import '../bloc/product_search_state.dart';
// import '../../core/common/widgets/appbar_searchbar.dart';
// import '../../domain/entities/product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    context
        .read<SearchPageBloc>()
        .add(const SearchProductsEvent('', forFilter: false));
    super.initState();
  }

  final TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void updateProductToFavorite(Product product, bool isLiked) {
      // print('updating the favorite');
      context.read<SearchPageBloc>().add(
            UpdateProductToFavoriteSearchPageEvent(
              product: product,
              isFavorited: !isLiked,
            ),
          );
    }

    // void updateProductToCart(
    //     {required Product product,
    //     required Cart? cart,
    //     required int itemCount}) {
    //   context.read<SearchPageBloc>().add(
    //         UpdateProductToCartSearchPageEvent(
    //           product: product,
    //           itemCount: itemCount,
    //           cart: cart,
    //         ),
    //       );
    // }

    // context.read<SearchPageBloc>().add(const SearchProductsEvent(null,));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: AppBarSearchBar(
          backButton: true,
          favouriteIconNeeded: false,
          deliveryPlaceNeeded: false,
          enabled: true,
          onChanged: (query) {
            context
                .read<SearchPageBloc>()
                .add(SearchProductsEvent(query, forFilter: false));
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<SearchPageBloc, SearchPageState>(
              buildWhen: (previous, current) => current is GetProductsState,
              builder: (context, state) {
                if (state is ProductSearchError) {
                  return Center(child: Text(state.message));
                } else if (state is ProductSearchLoaded) {
                  return state.products.isNotEmpty
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            mainAxisExtent: 300,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final currentProduct = state.products[index];
                            return ProductCard(
                                onTapCard: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRouteConstants.detailsPage,
                                      extra: currentProduct);
                                },
                                likeButton: CustomLikeButton(
                                  isFavorited: state.listOfFavoritedProducts
                                      .contains(currentProduct.productID),
                                  onTapFavouriteButton: (bool isLiked) async {
                                    updateProductToFavorite(
                                        currentProduct, isLiked);
                                    return isLiked ? false : true;
                                  },
                                ),
                                isHorizontal: false,
                                product: state.products[index],
                                // onTapFavouriteButton:
                                // isFavorited:
                                shoppingCartWidget: Container());
                          },
                        )
                      : const Center(
                          child: Text(
                            'No Products Found',
                          ),
                        );
                  //   ListView.builder(
                  //     itemCount: state.products.length,
                  //     itemBuilder: (context, index) {
                  //       final product = state.products[index];
                  //       return ListTile(
                  //         title: Text(product.name),
                  //         subtitle: Text(product.overview),
                  //       );
                  //     },
                  //   );
                }
                return const Loader();
              },
            ),
            // Positioned(
            //   bottom: 30,
            //   right: 0,
            //   left: 0,
            //   // width: 150,

            // )
          ],
        ),
      ),
      floatingActionButton: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        height: 60,
        width: 150,
        child: CustomBlurButton(
          title: 'Filter',
          onPressed: () {
            _showFilterBottomSheet(context);
          },
          up: true,
        ),
      ),

      // bottomNavigationBar:
    );
  }
}

void _showFilterBottomSheet(BuildContext context) {
  String? brandValue;
  List<int?> categoryIndexes = [null, null, null];
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      context.read<SearchPageBloc>().add(GetAllCategoriesEventForFilter());
      double minPrice = 0;
      double maxPrice = 10000;
      SfRangeValues currentRangeValues = SfRangeValues(minPrice, maxPrice);

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            height: 400,
            child: BlocConsumer<SearchPageBloc, SearchPageState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is FilterAllCategoryLoadedSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Filter Products',
                        // style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 16.0),
                      SfRangeSlider(
                        min: minPrice,
                        max: maxPrice,
                        values: currentRangeValues,
                        onChanged: (SfRangeValues values) {
                          setState(() {
                            currentRangeValues = values;
                          });
                        },
                        interval: 1500,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,
                        labelFormatterCallback: (actualValue, formattedText) {
                          return actualValue.toStringAsFixed(0);
                        },
                        numberFormat: NumberFormat('AED'),
                      ),
                      const SizedBox(height: 16.0),
                      // BlocConsumer<SearchPageBloc, SearchPageState>(
                      // listener: (context, state) {TODO: implement listener
                      //
                      // },
                      // buildWhen: (previous, current) =>
                      // current is FilterBottomSheetState,/
                      // builder: (context, state) {
                      // if (state is FilterAllCategoryLoadedSuccess) {
                      // return
                      // }\
                      CustomDropDown(
                        items: state.allBrandModel
                            .map((e) => e.categoryName)
                            .toList(),
                        currentItem: brandValue,
                        searchEditingController: searchEditingController,
                        onChanged: (value) {
                          setState(() {
                            brandValue = value;
                          });
                        },
                      ),
                      DropDownWidgets(
                          allCategories: state.allCategoryModel,
                          categoryIndexes: categoryIndexes),
                      // },
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: PrimaryAppButton(
                          onPressed: () {
                            // print(state.allCategoryModel[categoryIndexes[0]!]);
                            context
                                .read<SearchPageBloc>()
                                .add(SearchProductsEvent(
                                  null,
                                  forFilter: true,
                                  minPrice: currentRangeValues.start,
                                  maxPrice: currentRangeValues.end,
                                  brand: brandValue,
                                  mainCateogry: categoryIndexes[0] != null
                                      ? state
                                          .allCategoryModel[categoryIndexes[0]!]
                                          .categoryName
                                      : null,
                                  subCategory: categoryIndexes[0] != null &&
                                          categoryIndexes[1] != null
                                      ? state
                                          .allCategoryModel[categoryIndexes[0]!]
                                          .subCategories[categoryIndexes[1]!]
                                          .categoryName
                                      : null,
                                  variantCategory: categoryIndexes[0] != null &&
                                          categoryIndexes[1] != null &&
                                          categoryIndexes[2] != null
                                      ? state
                                          .allCategoryModel[categoryIndexes[0]!]
                                          .subCategories[categoryIndexes[1]!]
                                          .subCategories[categoryIndexes[2]!]
                                          .categoryName
                                      : null,
                                ));
                            Navigator.pop(context);
                          },
                          buttonText: 'Search',
                        ),
                      ),
                    ],
                  );
                }
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Filter Products',
                        // style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 16.0),
                      SfRangeSlider(
                        min: minPrice,
                        max: maxPrice,
                        values: currentRangeValues,
                        onChanged: (SfRangeValues values) {
                          setState(() {
                            currentRangeValues = values;
                          });
                        },
                        interval: 1500,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,
                        labelFormatterCallback: (actualValue, formattedText) {
                          return actualValue.toStringAsFixed(0);
                        },
                        numberFormat: NumberFormat('AED'),
                      ),
                      const SizedBox(height: 16.0),
                      // BlocConsumer<SearchPageBloc, SearchPageState>(
                      // listener: (context, state) {TODO: implement listener
                      //
                      // },
                      // buildWhen: (previous, current) =>
                      // current is FilterBottomSheetState,/
                      // builder: (context, state) {
                      // if (state is FilterAllCategoryLoadedSuccess) {
                      // return
                      // }\
                      CustomDropDown(
                        items: [].map((e) => e.categoryName).toList(),
                        currentItem: null,
                        searchEditingController: searchEditingController,
                      ),
                      // DropDownWidgets(
                      //     allCategories: state.allCategoryModel,
                      //     categoryIndexes: categoryIndexes),
                      // },
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: PrimaryAppButton(
                          onPressed: () {
                            // print(state.allCategoryModel[categoryIndexes[0]!]);
                            context
                                .read<SearchPageBloc>()
                                .add(SearchProductsEvent(
                                  null,
                                  forFilter: true,
                                  minPrice: currentRangeValues.start,
                                  maxPrice: currentRangeValues.end,
                                  brand: brandValue,
                                  // mainCateogry: categoryIndexes[0] != null
                                  //     ? state
                                  //         .allCategoryModel[categoryIndexes[0]!]
                                  //         .categoryName
                                  //     : null,
                                  // subCategory: categoryIndexes[0] != null &&
                                  //         categoryIndexes[1] != null
                                  //     ? state
                                  //         .allCategoryModel[categoryIndexes[0]!]
                                  //         .subCategories[categoryIndexes[1]!]
                                  //         .categoryName
                                  //     : null,
                                  // variantCategory: categoryIndexes[0] != null &&
                                  //         categoryIndexes[1] != null &&
                                  //         categoryIndexes[2] != null
                                  //     ? state
                                  //         .allCategoryModel[categoryIndexes[0]!]
                                  //         .subCategories[categoryIndexes[1]!]
                                  //         .subCategories[categoryIndexes[2]!]
                                  //         .categoryName
                                  //     : null,
                                ));
                            Navigator.pop(context);
                          },
                          buttonText: 'Search',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}

//     BlocBuilder<SearchPageBloc, SearchPageState>(
//   buildWhen: (previous, current) =>
//       current is ProductCartProductsState,
//   builder: (context, cartState) {
//     if (cartState is CartLoadedSuccessProductsState) {
//       ///if index =  0, then it will return -1 if the product is not carted
//       ///if index = 1, then it will return -1
//       ///if index = 2 , then it will return -1
//       ///
//       ///if there is product it will return the cart index

//       // final Product product =
//       //     listState.listOfProducts[index];
//       // final Cart cart = cartState.listOfCart.firstWhere(
//       //   (cart) => cart.productID == product.productID,
//       // );
//       bool productIsCarted = false;
//       final cartIndex = checkCurrentProductIsCarted(
//           product: state.products[index],
//           carts: cartState.listOfCart);

//       if (cartIndex > -1) {
//         productIsCarted = true;
//       }
//       return ShoppingCartButton(
//         onTapPlusButton: () {
//           if (productIsCarted &&
//               cartState.listOfCart[cartIndex]
//                       .productCount <=
//                   currentProduct.quantity) {
//             updateProductToCart(
//               product: currentProduct,
//               cart: cartState.listOfCart[cartIndex],
//               itemCount: cartState
//                       .listOfCart[cartIndex]
//                       .productCount +
//                   1,
//             );
//             //if the product is not carted yet . then we increase it by one
//           } else if (!productIsCarted) {
//             updateProductToCart(
//               product: currentProduct,
//               cart: null,
//               itemCount: 1,
//             );
//           }
//         },
//         onTapMinusButton: () {
//           if (productIsCarted &&
//               cartState.listOfCart[cartIndex]
//                           .productCount -
//                       1 >=
//                   0) {
//             updateProductToCart(
//               product: currentProduct,
//               cart: cartState.listOfCart[cartIndex],
//               itemCount: cartState
//                       .listOfCart[cartIndex]
//                       .productCount -
//                   1,
//             );
//           }
//           //if there is no product carted and the user clicks '-' then we show a
//           if (!productIsCarted) {
//             Fluttertoast.showToast(
//               msg: 'Add Product To Cart First',
//             );
//           }
//         },
//         onTapCartButton: () {},
//         currentCount: productIsCarted
//             ? cartState
//                 .listOfCart[cartIndex].productCount
//             : 0,
//         isLoading: false,
//       );
//     }
//     return const ShoppingCartButton(
//       currentCount: 0,
//       isLoading: true,
//     );
//   },
// ),