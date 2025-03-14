// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_a_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_fields.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/entities/address_details.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/get_all_user_address.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/save_user_address.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/send_order.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/show_present_payment_sheet.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/submit_payment_form.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final SubmitPaymentForm _submitPaymentForm;
  final UpdateProductFields _updateProductFields;
  final GetAProduct _getAProduct;
  final UpdateProductToCart _updateProductToCart;
  final SendOrder _sendOrder;
  // final GetAllProduct _getAllProduct;
  final GetAllUserAddress _getAllUserAddress;
  final SaveUserAddress _saveUserAddress;
  final GetAllCartProduct _getAllCartProduct;
  final GetUserData _getUserData;
  final GetAllCart _getAllCart;
  final ShowPresentPaymentSheet _showPresentPaymentSheet;
  CheckoutBloc(
      {required SubmitPaymentForm submitPaymentForm,
      required SendOrder sendOrder,
      required UpdateProductToCart updateProductToCart,
      required GetAllUserAddress getAllUserAddress,
      required SaveUserAddress saveUserAddress,
      required GetAllCart getAllCart,
      required GetUserData getUserData,
      required GetAllCartProduct getAllCartProduct,
      required GetAllProduct getAllProduct,
      required GetAProduct getAProduct,
      required UpdateProductFields updateProductFields,
      required ShowPresentPaymentSheet showPresentPaymentSheet})
      : _showPresentPaymentSheet = showPresentPaymentSheet,
        _getAllCart = getAllCart,
        _getUserData = getUserData,
        // _getAllProduct = getAllProduct,
        _saveUserAddress = saveUserAddress,
        _getAllUserAddress = getAllUserAddress,
        _submitPaymentForm = submitPaymentForm,
        _getAllCartProduct = getAllCartProduct,
        _sendOrder = sendOrder,
        _updateProductToCart = updateProductToCart,
        _getAProduct = getAProduct,
        _updateProductFields = updateProductFields,
        super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) {
      // emit(CheckoutLoading());
    });
    on<CheckoutInitialEmit>(
      (event, emit) {
        emit(CheckoutInitial());
      },
    );
    on<SaveUserAddressEvent>(_onSaveUserAddressEvent);
    // on<RemoveTheOrderEvent>(_onRemoveTheOrderEvent);
    on<SubmitPaymentFormEvent>(_onSubmitPaymentFormEvent);

    on<SaveOrderEvent>(_onSaveOrderEvent);
    on<RemoveAllProductsFromTheCartAndSendOrderEvent>(
        _onRemoveAllProductsFromTheCartEvent);
    on<ShowPresentPaymentSheetEvent>(_onShowPresentPaymentSheetEvent);
    on<LoadAddresses>(_onLoadAddresses);
    on<SelectAddress>(_onSelectAddress);
    on<UnselectAddress>(_onUnselectAddress);
  }

  FutureOr<void> _onSubmitPaymentFormEvent(
      SubmitPaymentFormEvent event, Emitter<CheckoutState> emit) async {
    // print('object');
    User? user;
    final userData = await _getUserData(NoParams());
    userData.fold(
        (failure) => emit(SubmitPaymentFormFailed(message: failure.message)),
        (success) async {
      user = success;
    });
    if (user != null) {
      final result = await _submitPaymentForm(SubmitPaymentFormParams(
          name: user!.username!,
          address: event.address,
          pin: event.pin,
          city: event.city,
          state: event.state,
          country: event.country,
          currency: event.currency,
          amount: event.amount));

      result.fold(
          (failure) => emit(SubmitPaymentFormFailed(message: failure.message)),
          (paymentIntentModel) => emit(SubmitPaymentFormSuccess(
              paymentIntentModel: paymentIntentModel)));
    } else {
      emit(const SubmitPaymentFormFailed(
          message: 'The User is not Available right now'));
    }
  }

  FutureOr<void> _onShowPresentPaymentSheetEvent(
      ShowPresentPaymentSheetEvent event, Emitter<CheckoutState> emit) async {
    final result = await _showPresentPaymentSheet(ShowPresentPaymentSheetParams(
        paymentIntentModel: event.paymentIntentModel));
    result.fold((failure) => emit(PaymentFailed(message: failure.message)),
        (success) => emit(PaymentSuccess(paymentIntentModel: success)));
  }

  FutureOr<void> _onRemoveAllProductsFromTheCartEvent(
      RemoveAllProductsFromTheCartAndSendOrderEvent event,
      Emitter<CheckoutState> emit) async {
    final allCarts = await _getAllCart(NoParams());

    allCarts.fold((l) => emit(AllCartClearedFailedState(message: l.message)),
        (carts) {
      carts.forEach((cart) async {
        final oneProduct =
            await _getAProduct(GetAProductParams(productID: cart.productID));

        // Product? product;
        num? newQuantity;
        oneProduct
            .fold((l) => emit(AllCartClearedFailedState(message: l.message)),
                (product) async {
          newQuantity = product.quantity - cart.productCount;
          // print(newQuantity);
          final updated = await _updateProductFields(UpdateProductFieldsParams(
              updates: {'quantity': newQuantity},
              productID: product.productID));
          updated.fold(
              (failed) =>
                  emit(AllCartClearedFailedState(message: failed.message)),
              (updated) async {
            await _updateProductToCart(UpdateProductToCartParams(
                itemCount: 0, product: product, cart: cart));
          });
        });
      });
      return emit(AllCartsClearedSuccessState(success: 'success'));
    });
  }

  // FutureOr<void> _onRemoveTheOrderEvent(
  //     RemoveTheOrderEvent event, Emitter<CheckoutState> emit) {}

  FutureOr<void> _onSaveOrderEvent(
      SaveOrderEvent event, Emitter<CheckoutState> emit) async {
    final user = await _getUserData(NoParams());
    final allCartedProducts = await _getAllCartProduct(NoParams());
    final allCarts = await _getAllCart(NoParams());

    List<Cart> listOfCartsOnly = [];
    List<Product> listOfCartedProducts = [];
    User? currentUser;

    user.fold((failure) => emit(SaveOrderFailed(message: failure.message)),
        (user) async {
      currentUser = user;
      // return emit(SaveOrderSuccess());
    });
    allCartedProducts
        .fold((failure) => emit(SaveOrderFailed(message: failure.message)),
            (allCartedProducts) async {
      // print('allcartsuccees');
      listOfCartedProducts = allCartedProducts;
    });

    allCarts.fold((failure) => emit(SaveOrderFailed(message: failure.message)),
        (allCart) async {
      // print('allcartssuccess');
      listOfCartsOnly = allCart;
    });

    if (currentUser != null &&
        listOfCartedProducts.isNotEmpty &&
        listOfCartsOnly.isNotEmpty) {
      // print(currentUser != null &&
      //     listOfCartedProducts.isNotEmpty &&
      //     listOfCartsOnly.isNotEmpty);
      // print(event.paymentIntentModel);
      final orderSend = await _sendOrder(SendOrderParams(
        paymentIntentModel: event.paymentIntentModel,
        user: currentUser!,
        products: listOfCartedProducts,
        carts: listOfCartsOnly,
      ));

      orderSend
          .fold((failure) => emit(SaveOrderFailed(message: failure.message)),
              (success) {
        // print('ordersendsuccess');
        return emit(SaveOrderSuccess());
      });
    }
  }

  Future<void> _onLoadAddresses(
      LoadAddresses event, Emitter<CheckoutState> emit) async {
    // emit(AddressLoading());
    String? userID;
    final user = await _getUserData(NoParams());
    user.fold((failed) => emit(AddressFailed(message: failed.message)),
        (user) => userID = user!.uid);

    if (userID != null) {
      final addresses =
          await _getAllUserAddress(GetAllUserAddressParams(userID: userID!));
      addresses.fold((failure) => emit(AddressFailed(message: failure.message)),
          (success) => emit(AddressLoaded(addresses: success)));
    }
    // emit(AddressLoaded(addresses: ));
  }

  void _onSelectAddress(SelectAddress event, Emitter<CheckoutState> emit) {
    emit(AddressSelected(event.address));
  }

  void _onUnselectAddress(UnselectAddress event, Emitter<CheckoutState> emit) {
    emit(AddressUnselected());
  }

  FutureOr<void> _onSaveUserAddressEvent(
      SaveUserAddressEvent event, Emitter<CheckoutState> emit) async {
    final result = await _saveUserAddress(SaveUserAddressParams(
        address: event.address,
        pin: event.pin,
        city: event.city,
        state: event.state,
        country: event.country));
    result.fold(
        (failure) => emit(SaveUserAddressFailed(message: failure.message)),
        (success) => emit(SaveUserAddressSuccess()));
  }
}
