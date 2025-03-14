import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_brands.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_category.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  static List<Category>? allCategoryModel;
  static List<Category>? allBrandModel;
  final GetAllProduct _getAllProduct;
  final UpdateProductToFavorite _updateProductToFavorite;
  final GetAllBrands _getAllBrands;
  final GetAllFavorite _getAllFavorite;
  final GetAllCategory _getAllCategory;
  List<Product> _allProducts = [];
  List<String> listOfFavorite = [];
  SearchPageBloc(
      {required GetAllProduct getAllProduct,
      required GetAllCategory getAllCategory,
      required GetAllFavorite getAllFavorite,
      required GetAllCart getAllCart,
      required GetAllBrands getAllBrands,
      required UpdateProductToFavorite updateProductToFavorite,
      required UpdateProductToCart updateProductToCart})
      : _getAllProduct = getAllProduct,
        _getAllCategory = getAllCategory,
        _getAllFavorite = getAllFavorite,
        _getAllBrands = getAllBrands,
        _updateProductToFavorite = updateProductToFavorite,
        super(ProductSearchInitial()) {
    on<SearchProductsEvent>(_onSearchProductsEvent,
        transformer: (events, mapper) {
      return events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper);
    });
    on<UpdateProductToFavoriteSearchPageEvent>(
        _onUpdateProductToFavoriteSearchPageEvent);
    // on<GetAllCartProductsEvent>(_onGetAllCartProductsEvent);
    on<UpdateProductToCartSearchPageEvent>(
        _onUpdateProductToCartSearchPageEvent);

    on<GetAllCategoriesEventForFilter>(_onGetAllCategoriesEventForFilter);
  }

  void _onSearchProductsEvent(
      SearchProductsEvent event, Emitter<SearchPageState> emit) async {
    emit(ProductSearchLoading());
    final allFavorited = await _getAllFavorite(NoParams());
    allFavorited.fold((failure) => emit(ProductSearchError(failure.message)),
        (success) {
      listOfFavorite = success; // Assigning value here
    });

    if (_allProducts.isEmpty) {
      final result = await _getAllProduct(NoParams());
      result.fold(
        (error) => emit(ProductSearchError(error.toString())),
        (products) {
          _allProducts = products;
          _filterProducts(
              query: event.query,
              emit: emit,
              listOfFavorites: listOfFavorite,
              minPrice: event.minPrice,
              maxPrice: event.maxPrice,
              forFilter: event.forFilter,
              brand: event.brand,
              mainCategory: event.mainCateogry,
              subCategory: event.subCategory,
              variantCategory: event.variantCategory);
        },
      );
    } else {
      _filterProducts(
          query: event.query,
          emit: emit,
          listOfFavorites: listOfFavorite,
          minPrice: event.minPrice,
          maxPrice: event.maxPrice,
          forFilter: event.forFilter,
          brand: event.brand,
          mainCategory: event.mainCateogry,
          subCategory: event.subCategory,
          variantCategory: event.variantCategory);
    }
  }

  void _filterProducts({
    required String? query,
    required Emitter<SearchPageState> emit,
    required List<String> listOfFavorites,
    required double minPrice,
    required double maxPrice,
    required bool forFilter,
    String? brand,
    String? mainCategory,
    String? subCategory,
    String? variantCategory,
  }) async {
    List<Product> filteredProducts = _allProducts;

    if (query != null && query.isNotEmpty) {
      final lowerCaseQuery = query.toLowerCase();
      filteredProducts = filteredProducts.where((product) {
        return product.brandName.toLowerCase().contains(lowerCaseQuery) ||
            product.name.toLowerCase().contains(lowerCaseQuery) ||
            product.overview.toLowerCase().contains(lowerCaseQuery) ||
            product.subCategory.toLowerCase().contains(lowerCaseQuery) ||
            product.mainCategory.toLowerCase().contains(lowerCaseQuery) ||
            product.variantCategory.toLowerCase().contains(lowerCaseQuery) ||
            product.vendorName.toLowerCase().contains(lowerCaseQuery);
      }).toList();
    }

    if (forFilter) {
      filteredProducts = filteredProducts.where((product) {
        bool matchesPriceRange =
            product.prize >= minPrice && product.prize <= maxPrice;
        bool matchesBrand = brand != null ? product.brandName == brand : true;
        bool matchesMainCategory =
            mainCategory != null ? product.mainCategory == mainCategory : true;
        bool matchesSubCategory =
            subCategory != null ? product.subCategory == subCategory : true;
        bool matchesVariantCategory = variantCategory != null
            ? product.variantCategory == variantCategory
            : true;
        // print(brand);
        // Handle combinations of categories and brand
        if (brand != null) {
          if (mainCategory != null &&
              subCategory != null &&
              variantCategory != null) {
            return matchesPriceRange &&
                matchesBrand &&
                matchesMainCategory &&
                matchesSubCategory &&
                matchesVariantCategory;
          } else if (mainCategory != null && subCategory != null) {
            return matchesPriceRange &&
                matchesBrand &&
                matchesMainCategory &&
                matchesSubCategory;
          } else if (mainCategory != null) {
            return matchesPriceRange && matchesBrand && matchesMainCategory;
          } else {
            return matchesPriceRange && matchesBrand;
          }
        } else {
          if (mainCategory != null &&
              subCategory != null &&
              variantCategory != null) {
            return matchesPriceRange &&
                matchesMainCategory &&
                matchesSubCategory &&
                matchesVariantCategory;
          } else if (mainCategory != null && subCategory != null) {
            return matchesPriceRange &&
                matchesMainCategory &&
                matchesSubCategory;
          } else if (mainCategory != null) {
            return matchesPriceRange && matchesMainCategory;
          } else {
            return matchesPriceRange;
          }
        }
      }).toList();
    }
    // print(filteredProducts.length);
    emit(ProductSearchLoaded(
        filteredProducts
            .where((product) => product.isPublished == true)
            .toList(),
        listOfFavorites));
  }

  FutureOr<void> _onUpdateProductToFavoriteSearchPageEvent(
      UpdateProductToFavoriteSearchPageEvent event,
      Emitter<SearchPageState> emit) async {
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

  FutureOr<void> _onUpdateProductToCartSearchPageEvent(
      UpdateProductToCartSearchPageEvent event,
      Emitter<SearchPageState> emit) async {}

  // FutureOr<void> _onGetAllCartProductsEvent(GetAllCartProductsEvent event, Emitter<SearchPageState> emit) {
  // }

  FutureOr<void> _onGetAllCategoriesEventForFilter(
      GetAllCategoriesEventForFilter event,
      Emitter<SearchPageState> emit) async {
    final result =
        await _getAllCategory(GetAllCategoryParams(refreshPage: false));
    final allbrands = await _getAllBrands(NoParams());

    allbrands.fold((l) => null, (r) => allBrandModel = r);
    result.fold(
        (failure) =>
            emit(FilterAllCategoryLoadedFailed(message: failure.message)),
        (success) {
      // isCategoryLoaded = true;
      allCategoryModel = success;
      emit(FilterAllCategoryLoadedSuccess(
          allCategoryModel: allCategoryModel!, allBrandModel: allBrandModel!));
    });
    // }
  }
}
