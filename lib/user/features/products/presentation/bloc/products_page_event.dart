part of 'products_page_bloc.dart';

sealed class ProductsPageEvent extends Equatable {
  const ProductsPageEvent();

  @override
  List<Object> get props => [];
}

// final class GetAllProductsForProductsPageEvent extends ProductsPageEvent{}

final class GetAllProductsProductsEvent extends ProductsPageEvent {
  final String searchQuery;
  final bool isCategorySearch;
  const GetAllProductsProductsEvent(
      {required this.isCategorySearch, required this.searchQuery});
}

final class GetAllBannerProductsEvent extends ProductsPageEvent {}

final class GetAllCartProductsEvent extends ProductsPageEvent {}

final class UpdateProductToFavoriteProductsEvent extends ProductsPageEvent {
  final bool isFavorited;
  final Product product;

  const UpdateProductToFavoriteProductsEvent(
      {required this.product, required this.isFavorited});
}

final class UpdateProductToCartProductsEvent extends ProductsPageEvent {
  final int itemCount;
  final Product product;
  final Cart? cart;
  const UpdateProductToCartProductsEvent(
      {required this.itemCount, required this.product, required this.cart});
}
