import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/title_with_count_bar.dart';
import 'package:tech_haven/user/features/favorite/presentation/bloc/favorite_page_bloc.dart';
import '../../../../../core/common/widgets/rectangular_product_card.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> updateProductToFavorite({required Product product}) async {
      final boolean = await showConfirmationDialog(
          context,
          'Remove From Favorites',
          'Are You Sure You Want To Remove this Product From Favorites', () {
        context.read<FavoritePageBloc>().add(
              RemoveProductToFavoriteEvent(product: product),
            );
      });
      return boolean!;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FavoritePageBloc>().add(GetAllFavoritedProducts());
    });

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppBarSearchBar(
          favouriteIconNeeded: false,
          backButton: true,
          
        ),
        body: Column(
          children: [
            // Header Section
            BlocBuilder<FavoritePageBloc, FavoritePageState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleWithCountBar(
                        title: 'Favorites',
                        itemsCount: state is FavoritePageLoadedSuccess
                            ? '${state.listOfFavoritedProduct.length} Items'
                            : '0 Items',
                        isForFavorite: true,
                        
                        
                      ),
                    ],
                  ),
                );
              },
            ),
            // Product List Section
            Expanded(
              child: BlocConsumer<FavoritePageBloc, FavoritePageState>(
                listener: (context, state) {
                  if (state is FavoriteRemovedSuccess) {
                    context.read<FavoritePageBloc>().add(GetAllFavoritedProducts());
                    context.read<HomePageBloc>().add(GetAllProductsEvent());
                  }
                  if (state is FavoritePageLoadedFailed) {
                    showSnackBar(
                      context: context,
                      title: 'Oh',
                      content: state.message,
                      contentType: ContentType.failure,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is FavoritePageLoadedSuccess) {
                    return state.listOfFavoritedProduct.isEmpty
                        ? const Center(
                            child: Text(
                              'Your Favorites Are Empty',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: state.listOfFavoritedProduct.length,
                            itemBuilder: (context, index) {
                              final product = state.listOfFavoritedProduct[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(26, 0, 0, 0), // Slight white tint for contrast
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      // ignore: deprecated_member_use
                                      color: Colors.white.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: RectangularProductCard(
                                  isFavorite: true,
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                      AppRouteConstants.detailsPage,
                                      extra: product,
                                    );
                                  },
                                  isFavoriteCard: true,
                                  productName: product.name,
                                  productPrize: product.prize.toString(),
                                  vendorName: product.vendorName,
                                  deliveryDate: product.mainCategory,
                                  onTapFavouriteButton: (bool isLiked) async {
                                    final boolean = await updateProductToFavorite(
                                        product: product);
                                    return !boolean;
                                  },
                                  productImage: product.displayImageURL,
                                  textEditingController: null,
                                  
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const SizedBox(height: 15),
                          );
                  }
                  // Shimmer Loading Effect
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade900,
                          highlightColor: Colors.grey.shade800,
                          child: RectangularProductCard(
                            onTap: () {},
                            isFavoriteCard: true,
                            productName: 'Loading...',
                            productPrize: '000',
                            vendorName: 'Vendor',
                            deliveryDate: 'Category',
                            productImage: null,
                            textEditingController: null,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}