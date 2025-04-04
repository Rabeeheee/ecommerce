import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

part 'cart_page_event.dart';
part 'cart_page_state.dart';

class CartPageBloc extends Bloc<CartPageEvent, CartPageState> {
  final GetAllCartProduct _getAllCartProduct;
  final GetAllCart _getAllCart;
  final UpdateProductToFavorite _updateProductToFavorite;
  final GetAllFavorite _getAllFavorite;
  final UpdateProductToCart _updateProductToCart;
  CartPageBloc(
      {required GetAllProduct getAllProduct,
      required GetAllCartProduct getAllCartProduct,
      required GetAllCart getAllCart,
      required UpdateProductToFavorite updateProductToFavorite,
      required GetAllFavorite getAllFavorite,
      required UpdateProductToCart updateProductToCart})
      : _getAllCartProduct = getAllCartProduct,
        _getAllCart = getAllCart,
        _updateProductToFavorite = updateProductToFavorite,
        _getAllFavorite = getAllFavorite,
        _updateProductToCart = updateProductToCart,
        super(CartPageInitial()) {
    on<CartPageEvent>((event, emit) {
      emit(CartPageLoadingState());
    });
    on<GetAllProductsEvent>(_onGetAllProductsEvent);
    on<UpdateProductToFavoriteEvent>(
      _onUpdateProductToFavoriteEvent,
    );
    on<UpdateProductToCartEvent>(
      _onUpdateProductToCartEvent,
     
    );
  }

  FutureOr<void> _onGetAllProductsEvent(
      GetAllProductsEvent event, Emitter<CartPageState> emit) async {
    
    emit(CartPageLoadingState());
    final allCartedProduct = await _getAllCartProduct(NoParams());
    final allCart = await _getAllCart(NoParams());
    final allFavorite = await _getAllFavorite(NoParams());

    // List<Product> listOfFilteredProducts = [];
    List<String> listOfFavorites = [];
    List<Cart> listOfCarts = [];

    allCart.fold(
      (failure) => failure,
      (carts) {
        listOfCarts = carts;
      },
    );
    allFavorite.fold(
      (failure) => failure,
      (favorites) {
        listOfFavorites = favorites;
      },
    );

    allCartedProduct.fold((failure) {
      emit(CartProductsListViewFailed(message: failure.message));
    }, (products) {
      emit(CartProductsListViewSuccess(
        listOfProducts: products,
        listOfCarts: listOfCarts,
        listOfFavorites: listOfFavorites,
      ));
    });
  }

  

  FutureOr<void> _onUpdateProductToFavoriteEvent(
      UpdateProductToFavoriteEvent event, Emitter<CartPageState> emit) async {
    final result = await _updateProductToFavorite(
      UpdateProductToFavoriteParams(
        isFavorited: event.isFavorited,
        product: event.product,
      ),
    );

    result.fold(
        (failure) => emit(ProductUpdatedToFavoriteCartFailed(
              message: failure.message,
            )),
        (success) =>
            emit(ProductUpdatedToFavoriteCartSuccess(updatedSuccess: success)));
  }

  FutureOr<void> _onUpdateProductToCartEvent(
      UpdateProductToCartEvent event, Emitter<CartPageState> emit) async {
    final result = await _updateProductToCart(UpdateProductToCartParams(
        itemCount: event.itemCount, product: event.product, cart: event.cart));

    result.fold(
        (failed) => emit(CartUpdatedFailed(message: failed.message)),
        (success) => emit(CartUpdatedSuccess(
              updatedSuccess: success,
            )));
   
  }
}
