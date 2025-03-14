import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_a_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_owned_products.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/core/entities/trending_product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/usecase/fetch_trending_product.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_banner_home_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_sub_categories_home_page.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

EventTransformer<Event> debounceSequential<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetAllProduct _getAllProduct;
  // final GetUserOwnedProducts _getUserOwnedProducts;
  final GetAllBannerHomePage _getAllBannerHomePage;
  final GetAllCart _getAllCart;
  // final GetAllReviewsProduct _getAllReviewsProduct;
  final UpdateProductToFavorite _updateProductToFavorite;
  final GetAllFavorite _getAllFavorite;
  final FetchTrendingProduct _fetchTrendingProduct;
  final GetAProduct _getAProduct;
  final UpdateProductToCart _updateProductToCart;
  final GetAllSubCategoriesHomePage _getAllSubCategoriesHomePage;
  HomePageBloc({
    required GetAllProduct getAllProduct,
    required GetAProduct getAProduct,
    required FetchTrendingProduct fetchTrendingProduct,
    required GetAllBannerHomePage getAllBannerHomePage,
    required GetAllCart getAllCart,
    required UpdateProductToFavorite updateProductToFavorite,
    required GetAllFavorite getAllFavorite,
    required UpdateProductToCart updateProductToCart,
    required GetUserOwnedProducts getUserOwnedProducts,
    required GetAllSubCategoriesHomePage getAllSubCategoriesHomePage,
  })  : _getAllProduct = getAllProduct,
        // _getUserOwnedProducts = getUserOwnedProducts,
        _getAllBannerHomePage = getAllBannerHomePage,
        _getAllCart = getAllCart,
        _updateProductToFavorite = updateProductToFavorite,
        _getAllFavorite = getAllFavorite,
        _getAProduct = getAProduct,
        _updateProductToCart = updateProductToCart,
        _fetchTrendingProduct = fetchTrendingProduct,
        _getAllSubCategoriesHomePage = getAllSubCategoriesHomePage,
        super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      emit(HomePageLoadingState());
    });
    on<GetAllProductsEvent>(_onGetAllProductsEvent);
    on<GetAllBannerHomeEvent>(_onGetAllBannerEvent);
    on<GetAllCartHomeEvent>(_onGetAllCartEvent);
    on<BannerProductNavigateEvent>(_onBannerProductNavigateEvent);
    on<UpdateProductToFavoriteHomeEvent>(
      _onUpdateProductToFavoriteEvent,
    );
    on<GetAllFavoriteHomeEvent>(_onGetAllFavoriteHomeEvent);
    on<GetProductForAdvertisement>(_onGetProductForAdvertisement);
    on<UpdateProductToCartHomeEvent>(
      _onUpdateProductToCartEvent,
    );
    on<GetAllSubCategoriesHomeEvent>(_onGetAllSubCategoriesEvent);
    on<GetNowTrendingProductEvent>(_onGetNowTrendingProductEvent);
    // on<UpdateProductToCart>(_onUpdateProductToCart);
  }

  FutureOr<void> _onGetAllProductsEvent(
      GetAllProductsEvent event, Emitter<HomePageState> emit) async {
    // List<String> listOfAllFavorited = [];

    final allProducts = await _getAllProduct(NoParams());
    allProducts.fold((failure) {
      return emit(
          HorizontalProductsListViewHomeFailed(message: failure.message));
    }, (success) {
      return emit(HorizontalProductsListViewHomeSuccess(
        listOfProducts: success.where((product) => product.isPublished == true).toList(),
        // listOfFavoritedProducts: listOfAllFavorited,
      ));
    });

    final allCarted = await _getAllCart(NoParams());
    allCarted.fold(
        (failure) => emit(CartLoadedFailedHomeState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessHomeState(
        listOfCart: success,
      ));
    });

    final favorite = await _getAllFavorite(NoParams());

    favorite.fold(
        (failure) => emit(FavoriteLoadedFailedHomeState(
              message: failure.message,
            )), (success) {
      return emit(FavoriteLoadedSuccessHomeState(
        listOfFavorite: success,
      ));
    });
  }

  FutureOr<void> _onGetAllBannerEvent(
      GetAllBannerHomeEvent event, Emitter<HomePageState> emit) async {
    final result = await _getAllBannerHomePage(NoParams());

    result.fold((failure) {
      emit(GetAllBannerHomeFailed(message: failure.message));
    }, (success) {
      emit(GetAllBannerHomeSuccess(listOfBanners: success));
    });
  }

  FutureOr<void> _onUpdateProductToFavoriteEvent(
      UpdateProductToFavoriteHomeEvent event,
      Emitter<HomePageState> emit) async {
    final result = await _updateProductToFavorite(
      UpdateProductToFavoriteParams(
        isFavorited: event.isFavorited,
        product: event.product,
      ),
    );

    result.fold(
        (failure) => emit(ProductUpdatedToFavoriteHomeFailed(
              message: failure.message,
            )), (success) {
      return emit(ProductUpdatedToFavoriteHomeSuccess(updatedSuccess: success));
    });
  }

  FutureOr<void> _onUpdateProductToCartEvent(
      UpdateProductToCartHomeEvent event, Emitter<HomePageState> emit) async {
    emit(CartLoadingHomeState());
    final result = await _updateProductToCart(UpdateProductToCartParams(
        itemCount: event.itemCount, product: event.product, cart: event.cart));

    result.fold(
        (failed) =>
            emit(ProductUpdatedToCartHomeFailed(message: failed.message)),
        (success) => emit(ProductUpdatedToCartHomeSuccess(
              updatedSuccess: success,
            )));
  }

  FutureOr<void> _onGetAllCartEvent(
      GetAllCartHomeEvent event, Emitter<HomePageState> emit) async {
    emit(CartLoadingHomeState());
    final result = await _getAllCart(NoParams());

    result.fold(
        (failure) => emit(CartLoadedFailedHomeState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessHomeState(
        listOfCart: success,
      ));
    });
  }

  FutureOr<void> _onGetAllFavoriteHomeEvent(
      GetAllFavoriteHomeEvent event, Emitter<HomePageState> emit) async {
    // emit(CartLoadingHomeState());
    final result = await _getAllFavorite(NoParams());

    result.fold(
        (failure) => emit(FavoriteLoadedFailedHomeState(
              message: failure.message,
            )), (success) {
      return emit(FavoriteLoadedSuccessHomeState(
        listOfFavorite: success,
      ));
    });
  }

  FutureOr<void> _onGetAllSubCategoriesEvent(
      GetAllSubCategoriesHomeEvent event, Emitter<HomePageState> emit) async {
    final result = await _getAllSubCategoriesHomePage(NoParams());

    result.fold(
        (failure) => emit(GetAllSubCategoriesFailedState(
              message: failure.message,
            )), (success) {
      return emit(GetAllSubCategoriesSuccessState(
        listOfSubCategories: success,
      ));
    });
  }

  FutureOr<void> _onBannerProductNavigateEvent(
      BannerProductNavigateEvent event, Emitter<HomePageState> emit) async {
    final result =
        await _getAProduct(GetAProductParams(productID: event.productID));
    result.fold(
        (failure) =>
            emit(NavigateToDetailsPageFailed(message: failure.message)),
        (success) => emit(NavigateToDetailsPageSuccess(product: success)));
  }

  FutureOr<void> _onGetNowTrendingProductEvent(
      GetNowTrendingProductEvent event, Emitter<HomePageState> emit) async {
    final result = await _fetchTrendingProduct(NoParams());
    result.fold((failed) => emit(TrendingProductError(message: failed.message)),
        (success) {
      return emit(TrendingProductLoaded(product: success));
    });
  }

  FutureOr<void> _onGetProductForAdvertisement(
      GetProductForAdvertisement event, Emitter<HomePageState> emit) async {
    final result =
        await _getAProduct(GetAProductParams(productID: event.productID));
    result.fold(
        (failure) =>
            emit(GetProductForAdvertisementFailed(message: failure.message)),
        (success) => emit(GetProductForAdvertisementSuccess(product: success)));
  }
}
