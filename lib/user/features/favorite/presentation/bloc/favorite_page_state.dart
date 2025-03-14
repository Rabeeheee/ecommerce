part of 'favorite_page_bloc.dart';

sealed class FavoritePageState extends Equatable {
  const FavoritePageState();

  @override
  List<Object> get props => [];
}

final class FavoritePageInitial extends FavoritePageState {}

final class FavoritePageLoading extends FavoritePageState {}

final class FavoritePageLoadedSuccess extends FavoritePageState {
  final List<Product> listOfFavoritedProduct;
  const FavoritePageLoadedSuccess({required this.listOfFavoritedProduct});
}

final class FavoritePageLoadedFailed extends FavoritePageState {
  final String message;
  const FavoritePageLoadedFailed({required this.message});
}

final class FavoriteRemovedSuccess extends FavoritePageState {}

final class FavoriteRemovedFailed extends FavoritePageState {
  final String message;
  const FavoriteRemovedFailed({required this.message});
}
