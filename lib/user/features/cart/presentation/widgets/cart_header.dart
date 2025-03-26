import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/title_with_count_bar.dart';

class cartHeader extends StatelessWidget {
  const cartHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          BlocBuilder<CartPageBloc, CartPageState>(
            buildWhen: (previous, current) =>
                current is CartProductListViewState,
            builder: (context, listState) {
              if (listState is CartProductsListViewSuccess) {
                return listState.listOfCarts.isNotEmpty
                    ? TitleWithCountBar(
                        title: 'Cart',
                        itemsCount:
                            '${calculateTotalQuantity(listOfCarts: listState.listOfCarts)} Items',
                        totalPrize: 'AED ${calculateTotalPrize(
                          products: listState.listOfProducts,
                          carts: listState.listOfCarts,
                        )}',
                      )
                    : const Center(
                        child: Text('Your Cart is Empty'),
                      );
              }
              return const TitleWithCountBar(
                title: 'Cart',
                itemsCount: '0 Items',
              );
            },
          ),
        ],
      ),
    );
  }
}
