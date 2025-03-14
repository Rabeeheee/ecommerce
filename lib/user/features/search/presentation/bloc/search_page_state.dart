part of 'search_page_bloc.dart';

// sealed class SearchPageState extends Equatable {
//   const SearchPageState();

//   @override
//   List<Object> get props => [];
// }

// final class SearchPageInitial extends SearchPageState {}

// import 'package:equatable/equatable.dart';
// import '../../domain/entities/product.dart';

abstract class SearchPageState extends Equatable {
  const SearchPageState();

  @override
  List<Object> get props => [];
}

class GetProductsState extends SearchPageState {}

class ProductSearchInitial extends GetProductsState {}

class ProductSearchLoading extends GetProductsState {}

class ProductSearchLoaded extends GetProductsState {
  final List<Product> products;
  final List<String> listOfFavoritedProducts;
  ProductSearchLoaded(this.products, this.listOfFavoritedProducts);

  @override
  List<Object> get props => [products];
}

class ProductSearchError extends GetProductsState {
  final String message;

  ProductSearchError(this.message);

  @override
  List<Object> get props => [message];
}

final class ProductCartProductsState extends SearchPageState {}

final class CartLoadingProductsState extends ProductCartProductsState {}

final class CartLoadedSuccessProductsState extends ProductCartProductsState {
  final List<Cart> listOfCart;
  CartLoadedSuccessProductsState({required this.listOfCart});
}

final class CartLoadedFailedProductsState extends ProductCartProductsState {
  final String message;
  CartLoadedFailedProductsState({required this.message});
}

final class ProductUpdatedToCartProductsSuccess
    extends ProductCartProductsState {
  final bool updatedSuccess;
  ProductUpdatedToCartProductsSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToCartProductsFailed
    extends ProductCartProductsState {
  final String message;
  ProductUpdatedToCartProductsFailed({required this.message});
}

final class UpdateProductToFavoriteState extends SearchPageState {}

final class ProductUpdatedToFavoriteProductsSuccess
    extends UpdateProductToFavoriteState {
  final bool updatedSuccess;
  ProductUpdatedToFavoriteProductsSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToFavoriteProductsFailed
    extends UpdateProductToFavoriteState {
  final String message;
  ProductUpdatedToFavoriteProductsFailed({required this.message});
}

final class FilterBottomSheetState extends SearchPageState {}

final class FilterAllCategoryLoadedSuccess extends FilterBottomSheetState {
  final List<Category> allCategoryModel;
  final List<Category> allBrandModel;
  FilterAllCategoryLoadedSuccess(
      {required this.allCategoryModel, required this.allBrandModel});
}

final class FilterAllCategoryLoadedFailed extends FilterBottomSheetState {
  final String message;
  FilterAllCategoryLoadedFailed({required this.message});
}

final class FilterAllCategoryLoading extends FilterBottomSheetState {}
