import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
part 'products_page_event.dart';
part 'products_page_state.dart';

class ProductsPageBloc extends Bloc<ProductsPageEvent, ProductsPageState> {
  final GetAllProduct _getAllProduct;
  // final GetAllBannerHomePage _getAllBannerHomePage;
  final GetAllCart _getAllCart;
  final UpdateProductToFavorite _updateProductToFavorite;
  final GetAllFavorite _getAllFavorite;
  final UpdateProductToCart _updateProductToCart;
  // final GetAllSubCategoriesHomePage _getAllSubCategoriesHomePage;
  ProductsPageBloc({
    required GetAllProduct getAllProduct,
    // required GetAllBannerHomePage getAllBannerHomePage,
    required GetAllCart getAllCart,
    required UpdateProductToFavorite updateProductToFavorite,
    required GetAllFavorite getAllFavorite,
    required UpdateProductToCart updateProductToCart,
    // required GetAllSubCategoriesHomePage getAllSubCategoriesHomePage,
  })  : _getAllProduct = getAllProduct,
        // _getAllBannerHomePage = getAllBannerHomePage,
        _getAllCart = getAllCart,
        _updateProductToFavorite = updateProductToFavorite,
        _getAllFavorite = getAllFavorite,
        _updateProductToCart = updateProductToCart,
        // _getAllSubCategoriesHomePage = getAllSubCategoriesHomePage,
        super(ProductsPageInitial()) {
    on<ProductsPageEvent>((event, emit) {
      emit(ProductsPageLoadingState());
    });
    on<GetAllProductsProductsEvent>(_onGetAllProductsEvent);
    // on<GetAllBannerHomeEvent>(_onGetAllBannerEvent);
    on<GetAllCartProductsEvent>(_onGetAllCartProductsEvent);
    on<UpdateProductToFavoriteProductsEvent>(
      _onUpdateProductToFavoriteEvent,
    );

    on<UpdateProductToCartProductsEvent>(
      _onUpdateProductToCartEvent,
    );
    // on<GetAllSubCategoriesProductsEvent>(_onGetAllSubCategoriesEvent);
    // on<UpdateProductToCart>(_onUpdateProductToCart);
  }

  FutureOr<void> _onGetAllProductsEvent(GetAllProductsProductsEvent event,
      Emitter<ProductsPageState> emit) async {
    List<String> listOfAllFavorited = [];

    final allFavorited = await _getAllFavorite(NoParams());
    allFavorited.fold((failure) {
    }, (success) {
      listOfAllFavorited = success; // Assigning value here
    });
    final allProducts = await _getAllProduct(NoParams());
    allProducts.fold((failure) {
      emit(ProductsListViewProductsFailed(message: failure.message));
    }, (success) {
      List<Product> searchedProducts = [];
      if (event.isCategorySearch) {
        searchedProducts = success
            .where((element) =>
                element.variantCategoryID == event.searchQuery ||
                element.subCategoryID == event.searchQuery)
            .toList();
      } else {
        //  final hello =   searchedProducts
        //         .filter((t) => t.variantCategory == event.isCategorySearch);
      }

      emit(ProductsListViewProductsSuccess(
        listOfProducts: searchedProducts,
        listOfFavoritedProducts: listOfAllFavorited,
      ));
    });

    final allCarted = await _getAllCart(NoParams());
    allCarted.fold(
        (failure) => emit(CartLoadedFailedProductsState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessProductsState(
        listOfCart: success,
      ));
    });
  }

  // FutureOr<void> _onGetAllBannerEvent(
  //     GetAllBannerHomeEvent event, Emitter<ProductsPageState> emit) async {
  //   final result = await _getAllBannerHomePage(NoParams());

  //   result.fold((failure) {
  //     emit(GetAllBannerHomeFailed(message: failure.message));
  //   }, (success) {
  //     emit(GetAllBannerHomeSuccess(listOfBanners: success));
  //   });
  // }

  FutureOr<void> _onUpdateProductToFavoriteEvent(
      UpdateProductToFavoriteProductsEvent event,
      Emitter<ProductsPageState> emit) async {
    final result = await _updateProductToFavorite(
      UpdateProductToFavoriteParams(
        isFavorited: event.isFavorited,
        product: event.product,
      ),
    );

    result.fold(
        (failure) => emit(ProductUpdatedToFavoriteProductsFailed(
              message: failure.message,
            )),
        (success) => emit(
            ProductUpdatedToFavoriteProductsSuccess(updatedSuccess: success)));
  }

  FutureOr<void> _onUpdateProductToCartEvent(
      UpdateProductToCartProductsEvent event,
      Emitter<ProductsPageState> emit) async {
    emit(CartLoadingProductsState());
    final result = await _updateProductToCart(UpdateProductToCartParams(
        itemCount: event.itemCount, product: event.product, cart: event.cart));

    result.fold(
        (failed) =>
            emit(ProductUpdatedToCartProductsFailed(message: failed.message)),
        (success) => emit(ProductUpdatedToCartProductsSuccess(
              updatedSuccess: success,
            )));
  }

  FutureOr<void> _onGetAllCartProductsEvent(
      GetAllCartProductsEvent event, Emitter<ProductsPageState> emit) async {
    emit(CartLoadingProductsState());
    final result = await _getAllCart(NoParams());

    result.fold(
        (failure) => emit(CartLoadedFailedProductsState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessProductsState(
        listOfCart: success,
      ));
    });
  }

  // FutureOr<void> _onGetAllSubCategoriesProductsEvent(
  //     GetAllSubCategoriesProductsEvent event, Emitter<ProductsPageState> emit) async {
  //   final result = await _getAllSubCategoriesHomePage(NoParams());

  //   result.fold(
  //       (failure) => emit(GetAllSubCategoriesFailedState(
  //             message: failure.message,
  //           )), (success) {
  //     return emit(GetAllSubCategoriesSuccessState(
  //       listOfSubCategories: success,
  //     ));
  //   });
  // }
}
