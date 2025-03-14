part of 'products_page_bloc.dart';

sealed class ProductsPageState extends Equatable {
  const ProductsPageState();

  @override
  List<Object> get props => [];
}

final class ProductsPageInitial extends ProductsPageState {}

final class ProductsPageLoadingState extends ProductsPageState {}

final class ProductListViewState extends ProductsPageState {}

final class ProductsListViewProductsSuccess
    extends ProductListViewState {
  final List<Product> listOfProducts;
  final List<String> listOfFavoritedProducts;

  ProductsListViewProductsSuccess({
    required this.listOfProducts,
    required this.listOfFavoritedProducts,
  });
}

final class ProductsListViewProductsFailed
    extends ProductListViewState {
  final String message;
  ProductsListViewProductsFailed({required this.message});
}

final class BannerCarouselState extends ProductsPageState {}

// final class GetAllBannerProductsSuccess extends BannerCarouselState {
//   final List<Banner> listOfBanners;
//   GetAllBannerProductsSuccess({required this.listOfBanners});
// }

final class GetAllBannerProductsFailed extends BannerCarouselState {
  final String message;
  GetAllBannerProductsFailed({required this.message});
}

final class ProductCartProductsState extends ProductsPageState {}

final class CartLoadingProductsState extends ProductCartProductsState{}

final class CartLoadedSuccessProductsState extends ProductCartProductsState {
  final List<Cart> listOfCart;
  CartLoadedSuccessProductsState({required this.listOfCart});
}

final class CartLoadedFailedProductsState extends ProductCartProductsState {
  final String message;
  CartLoadedFailedProductsState({required this.message});
}

final class ProductUpdatedToCartProductsSuccess extends ProductCartProductsState {
  final bool updatedSuccess;
  ProductUpdatedToCartProductsSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToCartProductsFailed extends ProductCartProductsState {
  final String message;
  ProductUpdatedToCartProductsFailed({required this.message});
}

final class UpdateProductToFavoriteState extends ProductsPageState {}

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

// final class ProductCartState extends ProductsPageState {}



// final class ProductUpdatedToCartLoading extends UpdateProductToCartState {}

// final class CartLoadedFailedState extends UpdateProductToCartState {
//   final String message;
//   CartLoadedFailedState({required this.message});
// }













// final class GetAllSubCategoriesState extends ProductsPageState {}

// final class GetAllSubCategoriesSuccessState extends GetAllSubCategoriesState {
//   final List<Category> listOfSubCategories;
//   GetAllSubCategoriesSuccessState({required this.listOfSubCategories});
// }

// final class GetAllSubCategoriesFailedState extends GetAllSubCategoriesState {
//   final String message;
//   GetAllSubCategoriesFailedState({required this.message});
// }

// final class GetAllSubCategoriesLoadingState extends GetAllSubCategoriesState {
// }

