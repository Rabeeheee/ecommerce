import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/favorite/domain/usecase/get_all_favorited_products.dart';
import 'package:tech_haven/user/features/favorite/domain/usecase/remove_product_from_favorite.dart';

part 'favorite_page_event.dart';
part 'favorite_page_state.dart';

class FavoritePageBloc extends Bloc<FavoritePageEvent, FavoritePageState> {
  final GetAllFavoritedProductFavoritePage _getAllFavoritedProduct;
  final RemoveProductFavorite _removeProductFavorite;
  FavoritePageBloc(
      {required GetAllFavoritedProductFavoritePage getAllFavoritedProduct,
      required RemoveProductFavorite removeProductFavorite})
      : _getAllFavoritedProduct = getAllFavoritedProduct,
        _removeProductFavorite = removeProductFavorite,
        super(FavoritePageInitial()) {
    on<FavoritePageEvent>((event, emit) {
      emit(FavoritePageLoading());
    });
    on<GetAllFavoritedProducts>(_onGetAllFavoritedProducts);
    on<RemoveProductToFavoriteEvent>(_onRemoveProductToFavoriteEvent);
  }

  FutureOr<void> _onGetAllFavoritedProducts(
      GetAllFavoritedProducts event, Emitter<FavoritePageState> emit) async {
    final allFavorited = await _getAllFavoritedProduct(NoParams());

    allFavorited.fold((failure) {
      emit(FavoritePageLoadedFailed(message: failure.message));
    }, (success) {
      emit(FavoritePageLoadedSuccess(listOfFavoritedProduct: success));
    });
  }

  FutureOr<void> _onRemoveProductToFavoriteEvent(
      RemoveProductToFavoriteEvent event,
      Emitter<FavoritePageState> emit) async {
    final productRemoved = await _removeProductFavorite(
        RemoveProductFavoriteParams(product: event.product));
    productRemoved.fold((l) => emit(FavoriteRemovedFailed(message: l.message)),
        (r) => emit(FavoriteRemovedSuccess()));
  }
}
