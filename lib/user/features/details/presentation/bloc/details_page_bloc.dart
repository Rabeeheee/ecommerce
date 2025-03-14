import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_brand_related_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_reviews_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_images_for_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_product_review.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_owned_products.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/product_review.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import '../../../../../core/common/domain/usecase/get_all_cart.dart';
part 'details_page_event.dart';
part 'details_page_state.dart';

class DetailsPageBloc extends Bloc<DetailsPageEvent, DetailsPageState> {
  final GetUserOwnedProducts _getUserOwnedProducts;
  final GetImagesForProduct _getImagesForProduct;
  final GetAllReviewsProduct _getAllReviewsProduct;
  final GetAllCart _getAllCart;
  final GetAllFavorite _getAllFavorite;
  final GetProductReview _getProductReview;
  final UpdateProductToFavorite _updateProductToFavorite;
  final GetAllBrandRelatedProduct _getAllBrandRelatedProduct;

  final GetUserData _getUserData;
  final UpdateProductToCart _updateProductToCart;
  Map<int, List<model.Image>> mapOfListOfImages = {};
  DetailsPageBloc({
    required GetImagesForProduct getImagesForProduct,
    required GetUserOwnedProducts getUserOwnedProducts,
    required GetProductReview getProductReview,
    required GetAllBrandRelatedProduct getAllBrandRelatedProduct,
    required GetAllReviewsProduct getAllReviewsProduct,
    required GetUserData getUserData,
    required GetAllCart getAllCart,
    required UpdateProductToCart updateProductToCart,
    required GetAllFavorite getAllFavorite,
    required UpdateProductToFavorite updateProductToFavorite,
  })  : _getAllCart = getAllCart,
        _getAllBrandRelatedProduct = getAllBrandRelatedProduct,
        _getImagesForProduct = getImagesForProduct,
        _getProductReview = getProductReview,
        _getUserData = getUserData,
        _getUserOwnedProducts = getUserOwnedProducts,
        _getAllReviewsProduct = getAllReviewsProduct,
        _getAllFavorite = getAllFavorite,
        _updateProductToFavorite = updateProductToFavorite,
        _updateProductToCart = updateProductToCart,
        super(DetailsPageInitial()) {
    on<DetailsPageEvent>((event, emit) {
      emit(DetailsPageLoadingState());
    });
    // on<FetchReviewsEvent>(_onFetchReviewsEvent);
    on<GetAllImagesForProductEvent>(_onGetAllImagesForProductEvent);
    on<EmitInitial>((event, emit) {
      emit(DetailsPageInitial());
    });
    on<GetProductReviewEvent>(_onGetProductReviewEvent);
    on<ChangeProductColorEvent>(_onChangeProductColorEvent);
    on<GetProductCartDetailsEvent>(_onGetProductCartDetailsEvent);
    on<GetProductFavoriteDetailsEvent>(_onGetProductFavoriteDetailsEvent);
    on<UpdateProductToFavoriteDetailsEvent>(
        _onUpdateProductToFavoriteDetailsEvent);
    on<UpdateProductToCartDetailsEvent>(_onUpdateProductToCartDetailsEvent);
    on<GetAllBrandRelatedProductsDetailsEvent>(
        _onGetAllBrandRelatedProductsDetailsEvent);
    // on<GetUserOwnedProductsEvent>(_onGetUserOwnedProductsEvent);

    on<GetAllBrandRelatedCartDetailsEvent>(
        _onGetAllBrandRelatedCartDetailsEvent);
    on<GetAllReviewOfProductEvent>(_onGetAllReviewOfProductEvent);

    // on<UpdateProductToFavoriteBrandRelatedDetailsEvent>(
    //     _onUpdateProductToFavoriteBrandRelatedDetailsEvent);

    on<UpdateProductToCartBrandRelatedDetailsEvent>(
        _onUpdateProductToCartBrandRelatedDetailsEvent);
    on<EmitInitialFavoriteButtonState>(_onEmitInitialFavoriteButtonState);
  }

  FutureOr<void> _onGetAllImagesForProductEvent(
      GetAllImagesForProductEvent event, Emitter<DetailsPageState> emit) async {
    emit(DetailsPageInitial());

    final allProductImages = await _getImagesForProduct(
        GetImagesForProductParams(productID: event.productID));
    // print(allProductImages);
    // await Future.delayed(const Duration(seconds: 1));
    allProductImages.fold(
        (failure) =>
            emit(GetAllImagesForProductFailed(message: failure.message)),
        (success) {
      mapOfListOfImages = success;
      return emit(GetAllImagesForProductSuccess(
          allImages: mapOfListOfImages, currentSelectedIndex: 0));
    });
  }

  FutureOr<void> _onChangeProductColorEvent(
      ChangeProductColorEvent event, Emitter<DetailsPageState> emit) async {
    // print('object');
    emit(DetailsPageInitial());
    // await Future.delayed(const Duration(seconds: 1));
    // print(event.index);
    emit(GetAllImagesForProductSuccess(
        allImages: mapOfListOfImages, currentSelectedIndex: event.index));
  }

  FutureOr<void> _onGetProductCartDetailsEvent(
      GetProductCartDetailsEvent event, Emitter<DetailsPageState> emit) async {
    // emit(CartDetailsState());
    final result = await _getAllCart(NoParams());

    result.fold(
        (failure) => emit(CartLoadedFailedDetailsState(
              message: failure.message,
            )), (success) {
      // print('hgfghfjhgj');
      Cart? cart;
      try {
        cart = success
            .firstWhere((element) => element.productID == event.productID);
      } catch (e) {
        cart =
            Cart(cartID: 'null', productID: 'null', productCount: 1, color: 0);
      }
      emit(CartLoadedSuccessDetailsState(
        cart: cart,
      ));
    });
  }

  FutureOr<void> _onUpdateProductToCartDetailsEvent(
      UpdateProductToCartDetailsEvent event,
      Emitter<DetailsPageState> emit) async {
    final result = await _updateProductToCart(UpdateProductToCartParams(
        itemCount: event.itemCount, product: event.product, cart: event.cart));
    result.fold(
        (l) => emit(UpdateProductToCartDetailsFailed(message: l.message)),
        (r) => emit(UpdateProductToCartDetailsSuccess()));
  }

  FutureOr<void> _onGetProductFavoriteDetailsEvent(
      GetProductFavoriteDetailsEvent event,
      Emitter<DetailsPageState> emit) async {
    final result = await _getAllFavorite(NoParams());
    result.fold(
        (failure) =>
            emit(GetProductFavoritedDetailsFailed(message: failure.message)),
        (success) {
      // emit(GetProductFavoritedDetailsInitialState());
      // print(success[0]);
      return emit(GetProductFavoritedDetailsSuccess(favorited: success));
    });
  }

  FutureOr<void> _onUpdateProductToFavoriteDetailsEvent(
      UpdateProductToFavoriteDetailsEvent event,
      Emitter<DetailsPageState> emit) async {
    // print('object');
    final result = await _updateProductToFavorite(UpdateProductToFavoriteParams(
        isFavorited: event.isFavorited, product: event.product));

    result.fold((l) => emit(UpdateProductToFavoriteFailed(message: l.message)),
        (r) => emit(UpdateProductToFavoriteSuccess()));
  }

//for all the rest of the related products to be loaded and the rest is same as with the home page logics

  FutureOr<void> _onGetAllBrandRelatedProductsDetailsEvent(
      GetAllBrandRelatedProductsDetailsEvent event,
      Emitter<DetailsPageState> emit) async {
    // List<String> listOfAllFavorited = [];
    // String messageOfFavoriteError = 'error';
    // final allFavorited = await _getAllFavorite(NoParams());
    // allFavorited.fold((failure) {
    //   messageOfFavoriteError = failure.message;
    // }, (success) {
    //   listOfAllFavorited = success; // Assigning value here
    // });

    //   print(messageOfFavoriteError);

    final result = await _getAllBrandRelatedProduct(
        GetAllBrandRelatedProductParams(product: event.product));

    result.fold(
        (failed) => emit(GetAllBrandRelatedProductsDetailsFailedState(
            message: failed.message)), (success) {
      success.removeWhere(
          (element) => element.productID == event.product.productID);
      return emit(GetAllBrandRelatedProductsDetailsSuccessState(
          // listOfFavoritedProducts: listOfAllFavorited,
          listOfBrandedProducts: success));
    });

    // final allCarted = await _getAllCart(NoParams());
    // allCarted.fold(
    //     (failure) => emit(CartLoadedDetailsFailedState(
    //           message: failure.message,
    //         )), (success) {
    //   return emit(CartLoadedDetailsSuccessState(
    //     listOfCart: success,
    //   ));
    // });
  }

  FutureOr<void> _onGetAllBrandRelatedCartDetailsEvent(
      GetAllBrandRelatedCartDetailsEvent event,
      Emitter<DetailsPageState> emit) async {
    // emit(CartDetailsState());
    final result = await _getAllCart(NoParams());
    result.fold(
        (failure) => emit(CartLoadedFailedDetailsPageRelatedState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessDetailsPageRelatedState(
        listOfCart: success,
      ));
    });
  }

  FutureOr<void> _onUpdateProductToCartBrandRelatedDetailsEvent(
      UpdateProductToCartBrandRelatedDetailsEvent event,
      Emitter<DetailsPageState> emit) async {
    // emit(CartDetailsState());
    final result = await _updateProductToCart(UpdateProductToCartParams(
        itemCount: event.itemCount, product: event.product, cart: event.cart));

    result.fold(
        (failed) => emit(ProductUpdatedToCartDetailsPageRelatedFailed(
            message: failed.message)),
        (success) => emit(ProductUpdatedToCartDetailsPageRelatedSuccess(
              updatedSuccess: success,
            )));
  }

  FutureOr<void> _onEmitInitialFavoriteButtonState(
      EmitInitialFavoriteButtonState event,
      Emitter<DetailsPageState> emit) async {
    return emit(GetProductFavoritedDetailsInitialState());
  }

  FutureOr<void> _onGetAllReviewOfProductEvent(
      GetAllReviewOfProductEvent event, Emitter<DetailsPageState> emit) async {
    // print('hello sdlfs');
    emit(LoadReviewLoadingState());
    String? userID;
    final user = await _getUserData(NoParams());

    user.fold(
        (failed) =>
            emit(GetUserOwnedProdutsFailedState(message: failed.message)),
        (user) => userID = user!.uid!);
    final allProductReviews = await _getAllReviewsProduct(
        GetAllReviewsProductParams(productID: event.productID));
    List<String> listOfUserOwnedProducts = [];
    if (userID != null) {
      final userOwnedProducts = await _getUserOwnedProducts(NoParams());

      // if (productReview != null) {
      userOwnedProducts.fold(
          (failure) =>
              emit(GetUserOwnedProdutsFailedState(message: failure.message)),
          (success) => listOfUserOwnedProducts = success);
      // print(listOfUserOwnedProducts);
      allProductReviews.fold(
        (failure) => emit(LoadReviewFailedState(message: failure.message)),
        (success) => emit(
          LoadReviewSuccessState(
            userID: userID!,
            listOfReviews: success,
            allUserOwnedProducts: listOfUserOwnedProducts,
          ),
        ),
      );
    } else {
      emit(GetUserOwnedProdutsFailedState(message: 'No User ID Exists'));
    }
  }

  FutureOr<void> _onGetProductReviewEvent(
      GetProductReviewEvent event, Emitter<DetailsPageState> emit) async {
    // emit(LoadReviewLoadingState());
    final productReviewResult = await _getProductReview(
        GetProductReviewParams(productID: event.productID));
    productReviewResult.fold(
        (failure) => emit(LoadReviewModelFailedState(message: failure.message)),
        (success) => emit(LoadReviewModelSuccessState(productReview: success)));
  }

  // FutureOr<void> _onGetUserOwnedProductsEvent(GetUserOwnedProductsEvent event, Emitter<DetailsPageState> emit) {
  // }
}
