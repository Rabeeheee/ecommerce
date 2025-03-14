part of 'cart_page_bloc.dart';

sealed class CartPageEvent extends Equatable {
  const CartPageEvent();

  @override
  List<Object> get props => [];
}
final class GetAllProductsEvent extends CartPageEvent {}

final class GetAllBannerEvent extends CartPageEvent {}

final class GetAllCartEvent extends CartPageEvent {}

final class UpdateProductToFavoriteEvent extends CartPageEvent {
  final bool isFavorited;
  final Product product;

  const UpdateProductToFavoriteEvent(
      {required this.product, required this.isFavorited});
}

final class UpdateProductToCartEvent extends CartPageEvent {
  final int itemCount;
  final Product product;  final Cart? cart;
  const UpdateProductToCartEvent(
      {required this.itemCount, required this.product,required this.cart});
}

