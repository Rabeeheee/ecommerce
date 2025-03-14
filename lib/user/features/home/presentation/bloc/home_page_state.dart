part of 'home_page_bloc.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class TrendingProductState extends HomePageState {}

class TrendingProductInitial extends TrendingProductState {}

class TrendingProductLoading extends TrendingProductState {}

class TrendingProductLoaded extends TrendingProductState {
  final TrendingProduct product;

  TrendingProductLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

final class GetTrendingProductState extends HomePageState {}

final class GetProductForAdvertisementSuccess extends GetTrendingProductState {
  final Product product;
  GetProductForAdvertisementSuccess({required this.product});
}

final class GetProductForAdvertisementFailed extends GetTrendingProductState {
  final String message;
  GetProductForAdvertisementFailed({required this.message});
}

class TrendingProductError extends TrendingProductState {
  final String message;

  TrendingProductError({required this.message});

  @override
  List<Object> get props => [message];
}

final class HomePageInitial extends HomePageState {}

final class HomePageLoadingState extends HomePageState {}

final class HorizontalProductListViewState extends HomePageState {}

final class HorizontalProductsListViewHomeSuccess
    extends HorizontalProductListViewState {
  final List<Product> listOfProducts;
  // final List<String> listOfFavoritedProducts;

  HorizontalProductsListViewHomeSuccess({
    required this.listOfProducts,
    // required this.listOfFavoritedProducts,
  });
}

final class HorizontalProductsListViewHomeFailed
    extends HorizontalProductListViewState {
  final String message;
  HorizontalProductsListViewHomeFailed({required this.message});
}

final class BannerCarouselState extends HomePageState {}

final class GetAllBannerHomeSuccess extends BannerCarouselState {
  final List<Banner> listOfBanners;
  GetAllBannerHomeSuccess({required this.listOfBanners});
}

final class GetAllBannerHomeFailed extends BannerCarouselState {
  final String message;
  GetAllBannerHomeFailed({required this.message});
}

final class BannerCarouselNavigateState extends BannerCarouselState {}

final class NavigateToDetailsPageSuccess extends BannerCarouselNavigateState {
  final Product product;
  NavigateToDetailsPageSuccess({required this.product});
}

final class NavigateToDetailsPageFailed extends BannerCarouselNavigateState {
  final String message;
  NavigateToDetailsPageFailed({required this.message});
}

final class ProductCartHomeState extends HomePageState {}

final class CartLoadingHomeState extends ProductCartHomeState {}

final class CartLoadedSuccessHomeState extends ProductCartHomeState {
  final List<Cart> listOfCart;
  CartLoadedSuccessHomeState({required this.listOfCart});
}

final class CartLoadedFailedHomeState extends ProductCartHomeState {
  final String message;
  CartLoadedFailedHomeState({required this.message});
}


final class ProductUpdatedToCartHomeSuccess extends ProductCartHomeState {
  final bool updatedSuccess;
  ProductUpdatedToCartHomeSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToCartHomeFailed extends ProductCartHomeState {
  final String message;
  ProductUpdatedToCartHomeFailed({required this.message});
}


final class ProductFavoriteHomeState extends HomePageState {}

final class FavoriteLoadingHomeState extends ProductFavoriteHomeState {}

final class FavoriteLoadedSuccessHomeState extends ProductFavoriteHomeState {
  final List<String> listOfFavorite;
  FavoriteLoadedSuccessHomeState({required this.listOfFavorite});
}

final class FavoriteLoadedFailedHomeState extends ProductFavoriteHomeState {
  final String message;
  FavoriteLoadedFailedHomeState({required this.message});
}

final class ProductUpdatedToFavoriteHomeSuccess
    extends ProductFavoriteHomeState {
  final bool updatedSuccess;
  ProductUpdatedToFavoriteHomeSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToFavoriteHomeFailed
    extends ProductFavoriteHomeState {
  final String message;
  ProductUpdatedToFavoriteHomeFailed({required this.message});
}

// final class ProductUpdatedToFavoriteHomeSuccess extends ProductFavoriteHomeState {
//   final bool updatedSuccess;
//   ProductUpdatedToFavoriteHomeSuccess({required this.updatedSuccess});
// }

// final class ProductUpdatedToFavoriteHomeFailed extends ProductFavoriteHomeState {
//   final String message;
//   ProductUpdatedToFavoriteHomeFailed({required this.message});
// }

// final class UpdateProductToFavoriteState extends HomePageState {}


final class GetAllSubCategoriesState extends HomePageState {}

final class GetAllSubCategoriesSuccessState extends GetAllSubCategoriesState {
  final List<Category> listOfSubCategories;
  GetAllSubCategoriesSuccessState({required this.listOfSubCategories});
}

final class GetAllSubCategoriesFailedState extends GetAllSubCategoriesState {
  final String message;
  GetAllSubCategoriesFailedState({required this.message});
}

final class GetAllSubCategoriesLoadingState extends GetAllSubCategoriesState {}

///statew of the review

final class GetReviewsOfTheProductState extends HomePageState {}

final class GetReviewsOfTheProductSuccessState
    extends GetReviewsOfTheProductState {
  final List<Review> listOfReview;
  GetReviewsOfTheProductSuccessState({required this.listOfReview});
}
