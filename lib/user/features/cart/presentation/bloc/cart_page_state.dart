part of 'cart_page_bloc.dart';

sealed class CartPageState extends Equatable {
  const CartPageState();

  @override
  List<Object> get props => [];
}

final class CartPageInitial extends CartPageState {}

final class CartPageLoadingState extends CartPageState {}

final class CartProductListViewState extends CartPageState {}

final class CartProductsListViewSuccess extends CartProductListViewState {
  final List<Product> listOfProducts;
  final List<String> listOfFavorites;
  final List<Cart> listOfCarts;
  CartProductsListViewSuccess({
    required this.listOfCarts,
    required this.listOfProducts,
    required this.listOfFavorites,
  });
}

final class CartProductsListViewLoading extends CartProductListViewState {}

final class CartProductsListViewFailed extends CartProductListViewState {
  final String message;
  CartProductsListViewFailed({required this.message});
}

final class CartUpdatedSuccess extends CartProductListViewState {
  final bool updatedSuccess;
  CartUpdatedSuccess({required this.updatedSuccess});
}

final class CartUpdatedFailed extends CartProductListViewState {
  final String message;
  CartUpdatedFailed({required this.message});
}

// final class AddProductToCartState extends CartPageState {}

// final class ProductAddedToCartSuccess extends AddProductToCartState {
//   final bool addedSuccess;
//   ProductAddedToCartSuccess({required this.addedSuccess});
// }

// final class ProductAddedToCartFailed extends AddProductToCartState {
//   final String message;
//   ProductAddedToCartFailed({required this.message});
// }

final class UpdateProductToFavoriteState extends CartPageState {}

final class ProductUpdatedToFavoriteCartSuccess
    extends UpdateProductToFavoriteState {
  final bool updatedSuccess;
  ProductUpdatedToFavoriteCartSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToFavoriteCartFailed
    extends UpdateProductToFavoriteState {
  final String message;
  ProductUpdatedToFavoriteCartFailed({required this.message});
}

// final class CartLoadedSuccessState extends CartProductListViewState {
//   final List<Cart> listOfCart;
//   CartLoadedSuccessState({required this.listOfCart});
// }

// final class CartLoadedFailedState extends CartProductListViewState {
//   final String message;
//   CartLoadedFailedState({required this.message});
// }
