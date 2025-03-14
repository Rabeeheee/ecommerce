import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_brands.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/delete_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/get_all_category.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/register_new_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/update_existing_product.dart';

part 'register_product_event.dart';
part 'register_product_state.dart';

class RegisterProductBloc
    extends Bloc<RegisterProductEvent, RegisterProductState> {
  static bool isCategoryLoaded = false;
  static bool isBrandLoaded = false;
  static List<Category>? allCategoryModel;
  static List<Category>? allBrandModel;
  final GetAllCategoryForRegister _getAllCategoryForRegister;
  final RegisterNewProduct _registerNewProduct;
  final DeleteProduct _deleteProduct;
  final GetAllBrands _getAllBrands;
  final UpdateExistingProduct _updateExistingProduct;
  RegisterProductBloc({
    required GetAllCategoryForRegister getAllCategoryForRegister,
    required RegisterNewProduct registerNewProduct,
    required DeleteProduct deleteProduct,
    required UpdateExistingProduct updateExistingProduct,
    required GetAllBrands getAllBrands,
  })  : _getAllCategoryForRegister = getAllCategoryForRegister,
        _registerNewProduct = registerNewProduct,
        _deleteProduct = deleteProduct,
        _getAllBrands = getAllBrands,
        _updateExistingProduct = updateExistingProduct,
        super(RegisterProductInitial()) {
    on<RegisterProductEvent>((event, emit) {
      emit(RegisterProductLoading());
    });
    // on<EmitRegisterProductPageIniti
    on<GetAllCategoryEvent>(_onGetAllCategoryEvent);
    // on<GetAllBrandEvent>(_onGetAllBrandEvent);
    on<RegisterNewProductEvent>(_onRegisterNewProductEvent);
    on<DeleteTheProductEvent>(_onDeleteTheProductEvent);
    on<UpdateExistingProductEvent>(_onUpdateExistingProductEvent);
    on<OnChangeDynamicFormEvent>(_onOnChangeDynamicFormEvent);
  }

  FutureOr<void> _onGetAllCategoryEvent(
      GetAllCategoryEvent event, Emitter<RegisterProductState> emit) async {
    // if (isCategoryLoaded == false) {
    final result = await _getAllCategoryForRegister(
        GetAllCategoryForRegiseterParams(refresh: event.refreshPage));
    final allbrands = await _getAllBrands(NoParams());

    allbrands.fold((l) => null, (r) => allBrandModel = r);
    result.fold(
        (failure) => emit(
            RegisterProductAllCategoryLoadedFailed(message: failure.message)),
        (success) {
      isCategoryLoaded = true;
      allCategoryModel = success;
      emit(RegisterProductAllCategoryLoadedSuccess(
          allCategoryModel: allCategoryModel!, allBrandModel: allBrandModel!));
    });
    // }
  }

  FutureOr<void> _onRegisterNewProductEvent(
      RegisterNewProductEvent event, Emitter<RegisterProductState> emit) async {
    final result = await _registerNewProduct(RegisterNewProductParams(
      brandName: event.brandName,
      brandID: event.brandID,
      // vendorID: event.vendorID,
      productName: event.productName,
      productPrize: event.productPrize,
      oldPrize: event.productOldPrize,
      productQuantity: event.productQuantity, color: event.color,
      mainCategory: event.mainCategory,
      mainCategoryID: event.mainCategoryID,
      subCategory: event.subCategory,
      subCategoryID: event.subCategoryID,
      variantCategory: event.variantCategory,
      variantCategoryID: event.variantCategoryID,
      productOverview: event.productOverview,
      specifications: event.specifications,
      shippingCharge: event.shippingCharge,
      productImages: event.productImages,
      isPublished: event.isPublished,
    ));
    result.fold(
        (failure) => emit(NewProductRegisteredFailed(message: failure.message)),
        (registered) {
      return emit(
        NewProductRegisteredSuccess(newProductRegisterd: registered),
      );
    });
    emit(RegisterProductAllCategoryLoadedSuccess(
        allCategoryModel: allCategoryModel!, allBrandModel: allBrandModel!));
  }

  FutureOr<void> _onDeleteTheProductEvent(
      DeleteTheProductEvent event, Emitter<RegisterProductState> emit) async {
    final result = await _deleteProduct(DeleteProductParams(
        product: event.product, mapOfListOfImages: event.mapOfListOfImages));

    result.fold(
        (failed) => emit(DeleteProductFailed(message: failed.message)),
        (success) => emit(DeleteProductSuccess(
              deleteSuccess: success,
            )));
  }

  FutureOr<void> _onUpdateExistingProductEvent(UpdateExistingProductEvent event,
      Emitter<RegisterProductState> emit) async {
    final result = await _updateExistingProduct(UpdateExistingProductParams(
      product: event.product,
      brandName: event.brandName,
      brandID: event.brandID,
      color: event.color,
      productName: event.productName,
      productPrize: event.productPrize,
      oldProductPrize: event.productOldPrize,
      productQuantity: event.productQuantity,
      mainCategory: event.mainCategory,
      mainCategoryID: event.mainCategoryID,
      subCategory: event.subCategory,
      subCategoryID: event.subCategoryID,
      variantCategory: event.variantCategory,
      variantCategoryID: event.variantCategoryID,
      productOverview: event.productOverview,
      specifications: event.specifications,
      shippingCharge: event.shippingCharge,
      productImages: event.productImages,
      deleteImagesIndexes: event.deleteImagesIndexes,
      isPublished: event.isPublished,
    ));

    result.fold(
        (failure) => emit(NewProductRegisteredFailed(message: failure.message)),
        (registered) {
      return emit(
        NewProductRegisteredSuccess(newProductRegisterd: registered),
      );
    });
    emit(RegisterProductAllCategoryLoadedSuccess(
        allCategoryModel: allCategoryModel!, allBrandModel: allBrandModel!));
  }

  // FutureOr<void> _onGetAllBrandEvent(
  //     GetAllBrandEvent event, Emitter<RegisterProductState> emit) async {
  //   final allbrands = await _getAllBrands(NoParams());

  //   allbrands
  //       .fold((failure) => emit(GetAllBrandsFailed(message: failure.message)),
  //           (success) {
  //     print('slkjfslkd');
  //     isBrandLoaded = true;
  //     return emit(GetAllBrandsSuccess(listOfBrands: success));
  //   });
  // }

  FutureOr<void> _onOnChangeDynamicFormEvent(
      OnChangeDynamicFormEvent event, Emitter<RegisterProductState> emit) {
    emit(DynamicFormSuccessState(data: event.data));
  }
}
