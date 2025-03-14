part of 'favorite_page_bloc.dart';

sealed class FavoritePageEvent extends Equatable {
  const FavoritePageEvent();

  @override
  List<Object> get props => [];
}

final class GetAllFavoritedProducts extends FavoritePageEvent {}

final class RemoveProductToFavoriteEvent extends FavoritePageEvent {
  final Product product;
  const RemoveProductToFavoriteEvent({required this.product});
}
