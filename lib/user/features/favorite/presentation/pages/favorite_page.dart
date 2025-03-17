import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
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
    // var items = [
    //   '1',
    //   '2',
    //   '3',
    //   '4',
    //   '5',
    // ];
    return SafeArea(
      child: Scaffold(
        
        resizeToAvoidBottomInset: false,
        appBar: const AppBarSearchBar(
          favouriteIconNeeded: false,
          backButton: true,
        ),
        body: Column(
          children: [
            BlocBuilder<FavoritePageBloc, FavoritePageState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  color: AppPallete.lightgreyColor,
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
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
            Expanded(
              child: BlocConsumer<FavoritePageBloc, FavoritePageState>(
                listener: (context, state) {
                  if (state is FavoriteRemovedSuccess) {
                    context
                        .read<FavoritePageBloc>()
                        .add(GetAllFavoritedProducts());
                    context.read<HomePageBloc>().add(GetAllProductsEvent());
                  }
                  if (state is FavoritePageLoadedFailed) {
                    showSnackBar(
                        context: context,
                        title: 'Oh',
                        content: state.message,
                        contentType: ContentType.failure);
                  }
                },
                builder: (context, state) {
                  if (state is FavoritePageLoadedSuccess) {
                    return state.listOfFavoritedProduct.isEmpty
                        ? const Center(
                            child: Text(
                              'Your Favorite Is Empty',
                              style: TextStyle(color: AppPallete.blackColor),
                            ),
                          )
                        : ListView.separated(
                            itemCount: state.listOfFavoritedProduct.length,
                            itemBuilder: (context, index) {
                              final product = state.listOfFavoritedProduct[index];
                              return RectangularProductCard(
                                isFavorite: true,
                                // items: items,
      
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRouteConstants.detailsPage,
                                      extra: product);
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
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 10,
                                color: AppPallete.lightgreyColor,
                              );
                            },
                          );
                  }
                  return ListView.separated(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade100,
                        highlightColor: Colors.grey.shade300,
                        child: RectangularProductCard(
                          // items: items,
                          onTap: () {},
                          isFavoriteCard: true,
                          productName: 'name',
                          productPrize: '000',
                          vendorName: ' vendor',
                          deliveryDate: 'Category',
                          productImage: null, textEditingController: null,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 10,
                        color: AppPallete.lightgreyColor,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
