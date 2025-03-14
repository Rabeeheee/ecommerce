import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_haven/core/common/bloc/common_bloc.dart';
import 'package:tech_haven/core/common/cubits/app_cubit/app_user_cubit.dart';
import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/common/data/datasource/data_source_impl.dart';
import 'package:tech_haven/core/common/data/repositories/repository_impl.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/common/domain/usecase/add_review.dart';
import 'package:tech_haven/core/common/domain/usecase/get_a_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_brand_related_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_brands.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_category.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_orders.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_reviews_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_current_location_details.dart';
import 'package:tech_haven/core/common/domain/usecase/get_images_for_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_product_review.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_owned_products.dart';
import 'package:tech_haven/core/common/domain/usecase/get_vendor_data.dart';
import 'package:tech_haven/core/common/domain/usecase/get_vendor_orders.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_fields.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/user/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/user/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:tech_haven/user/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/forgot_password_send_email.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/google_sign_up.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/send_otp_to_phone_number.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/create_user.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/update_user_phone_number.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/user_signin.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/verify_phone_number_and_sign_up.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:tech_haven/user/features/checkout/data/datasource/checkout_data_source_impl.dart';
import 'package:tech_haven/user/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:tech_haven/user/features/checkout/domain/repository/checkout_repository.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/get_all_user_address.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/save_user_address.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/send_order.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/show_present_payment_sheet.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/submit_payment_form.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';
import 'package:tech_haven/user/features/favorite/data/datasource/favorite_page_data_source.dart';
import 'package:tech_haven/user/features/favorite/data/datasource/favorite_page_data_source_impl.dart';
import 'package:tech_haven/user/features/favorite/data/repositories/favorite_page_repository_impl.dart';
import 'package:tech_haven/user/features/favorite/domain/repository/favorite_page_repository.dart';
import 'package:tech_haven/user/features/favorite/domain/usecase/get_all_favorited_products.dart';
import 'package:tech_haven/user/features/favorite/domain/usecase/remove_product_from_favorite.dart';
import 'package:tech_haven/user/features/favorite/presentation/bloc/favorite_page_bloc.dart';
import 'package:tech_haven/user/features/help%20center/data/datasource/help_center_data_source.dart';
import 'package:tech_haven/user/features/help%20center/data/datasource/help_center_data_source_impl.dart';
import 'package:tech_haven/user/features/help%20center/data/repositories/help_center_repository_impl.dart';
import 'package:tech_haven/user/features/help%20center/domain/repository/help_center_repsitory.dart';
import 'package:tech_haven/user/features/help%20center/domain/usecase/get_all_user_requests.dart';
import 'package:tech_haven/user/features/help%20center/domain/usecase/send_help_request_use_case.dart';
import 'package:tech_haven/user/features/help%20center/presentation/bloc/help_center_bloc.dart';
import 'package:tech_haven/user/features/home/data/datasource/home_page_data_source.dart';
import 'package:tech_haven/user/features/home/data/datasource/home_page_data_source_impl.dart';
import 'package:tech_haven/user/features/home/data/repositories/home_page_repository_impl.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';
import 'package:tech_haven/user/features/home/domain/usecase/fetch_trending_product.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_banner_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_sub_categories_home_page.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/map/domain/usecase/update_location.dart';
import 'package:tech_haven/user/features/map/presentation/bloc/map_page_bloc.dart';
import 'package:tech_haven/user/features/order%20history/data/datasource/user_order_history_data_source.dart';
import 'package:tech_haven/user/features/order%20history/data/datasource/user_order_history_data_source_impl.dart';
import 'package:tech_haven/user/features/order%20history/data/repositories/user_order_history_repository_impl.dart';
import 'package:tech_haven/user/features/order%20history/domain/repository/user_order_history_repositry.dart';
import 'package:tech_haven/user/features/order%20history/domain/usecase/get_all_user_order_history.dart';
import 'package:tech_haven/user/features/order%20history/presentation/bloc/user_order_history_page_bloc.dart';
import 'package:tech_haven/user/features/order/presentation/bloc/user_order_page_bloc.dart';
import 'package:tech_haven/user/features/ordredProducts/data/datasource/ordered_products_page_data_source.dart';
import 'package:tech_haven/user/features/ordredProducts/data/datasource/ordered_products_page_data_source_impl.dart';
import 'package:tech_haven/user/features/ordredProducts/data/repositories/ordered_products_page_repository_impl.dart';
import 'package:tech_haven/user/features/ordredProducts/domain/repository/ordered_products_page_repository.dart';
import 'package:tech_haven/user/features/ordredProducts/domain/usecase/get_user_ordered_products.dart';
import 'package:tech_haven/user/features/ordredProducts/presentation/bloc/ordered_products_page_bloc.dart';
import 'package:tech_haven/user/features/products/presentation/bloc/products_page_bloc.dart';
import 'package:tech_haven/user/features/profile%20edit/data/datasource/profile_edit_page_data_source.dart';
import 'package:tech_haven/user/features/profile%20edit/data/datasource/profile_edit_page_data_source_impl.dart';
import 'package:tech_haven/user/features/profile%20edit/data/repositories/profile_edit_page_repository_impl.dart';
import 'package:tech_haven/user/features/profile%20edit/domain/repository/profile_edit_page_repository.dart';
import 'package:tech_haven/user/features/profile%20edit/domain/usecase/update_user_data.dart';
import 'package:tech_haven/user/features/profile%20edit/presentation/bloc/profile_edit_page_bloc.dart';
import 'package:tech_haven/user/features/profile/data/datasource/user_profile_page_data_source.dart';
import 'package:tech_haven/user/features/profile/data/datasource/user_profile_page_data_source_impl.dart';
import 'package:tech_haven/user/features/profile/data/repositories/user_profile_page_repository_impl.dart';
import 'package:tech_haven/user/features/profile/domain/repository/user_profile_page_repository.dart';
import 'package:tech_haven/user/features/profile/domain/usecase/send_otp_for_google_login.dart';
import 'package:tech_haven/user/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tech_haven/user/features/review%20enter/presentation/bloc/review_enter_page_bloc.dart';
import 'package:tech_haven/user/features/reviews/data/datasource/review_page_data_source.dart';
import 'package:tech_haven/user/features/reviews/data/datasource/review_page_data_source_impl.dart';
import 'package:tech_haven/user/features/reviews/data/repositories/review_page_repository_impl.dart';
import 'package:tech_haven/user/features/reviews/domain/repository/review_page_repository.dart';
import 'package:tech_haven/user/features/reviews/domain/usecase/update_user_helpful.dart';
import 'package:tech_haven/user/features/reviews/presentation/bloc/review_page_bloc.dart';
import 'package:tech_haven/user/features/search/data/datasource/search_page_data_source.dart';
import 'package:tech_haven/user/features/search/data/datasource/search_page_data_source_impl.dart';
import 'package:tech_haven/user/features/search/data/repositories/search_page_repository_impl.dart';
import 'package:tech_haven/user/features/search/domain/repository/search_page_repository.dart';
import 'package:tech_haven/user/features/search/domain/usecase/search_products.dart';
import 'package:tech_haven/user/features/search/presentation/bloc/search_page_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/data/datasource/search_category_data_source.dart';
import 'package:tech_haven/user/features/searchcategory/data/datasource/search_category_data_source_impl.dart';
import 'package:tech_haven/user/features/searchcategory/data/repositories/search_category_repository_impl.dart';
import 'package:tech_haven/user/features/searchcategory/domain/repository/search_category_repository.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/bloc/search_category_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/cubit/search_category_cubit.dart';
import 'package:tech_haven/vendor/features/manageproduct/data/datasource/manage_product_data_source.dart';
import 'package:tech_haven/vendor/features/manageproduct/data/datasource/manage_product_data_source_impl.dart';
import 'package:tech_haven/vendor/features/manageproduct/data/repositories/manage_product_repository_impl.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/repository/manage_product_repository.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/usecase/get_all_products.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/usecase/update_the_product_publish.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/bloc/manage_product_bloc.dart';
import 'package:tech_haven/vendor/features/order/data/datasource/order_data_source.dart';
import 'package:tech_haven/vendor/features/order/data/datasource/order_data_source_impl.dart';
import 'package:tech_haven/vendor/features/order/data/repositories/order_repository_impl.dart';
import 'package:tech_haven/vendor/features/order/domain/repository/order_repository.dart';
import 'package:tech_haven/vendor/features/order/domain/usecase/delete_order.dart';
import 'package:tech_haven/vendor/features/order/presentation/bloc/vendor_order_page_bloc.dart';
import 'package:tech_haven/vendor/features/orderdetails/presentation/bloc/vendor_order_details_bloc.dart';
import 'package:tech_haven/vendor/features/profile/data/datasource/vendor_profile_data_source.dart';
import 'package:tech_haven/vendor/features/profile/data/datasource/vendor_profile_data_source_impl.dart';
import 'package:tech_haven/vendor/features/profile/data/repositories/vendor_profile_repository_impl.dart';
import 'package:tech_haven/vendor/features/profile/domain/repository/vendor_profile_repository.dart';
import 'package:tech_haven/vendor/features/profile/domain/usecase/get_vendor_profile.dart';
import 'package:tech_haven/vendor/features/profile/presentation/bloc/vendor_profile_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/datasource/register_product_data_source.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/datasource/register_product_data_source_impl.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/repositories/register_product_repostory_imp.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/delete_product.dart';
// import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/get_all_brands.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/get_all_category.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/register_new_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/update_existing_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/bloc/get_images_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/bloc/register_product_bloc.dart';
import 'package:tech_haven/vendor/features/registervendor/data/datasource/register_vendor_datasource.dart';
import 'package:tech_haven/vendor/features/registervendor/data/datasource/register_vendor_datasource_impl.dart';
import 'package:tech_haven/vendor/features/registervendor/data/repositories/register_vendor_repository_impl.dart';
import 'package:tech_haven/vendor/features/registervendor/domain/repository/register_vendor_repository.dart';
import 'package:tech_haven/vendor/features/registervendor/domain/usecase/send_request_for_vendor.dart';
import 'package:tech_haven/vendor/features/registervendor/presentation/bloc/register_vendor_bloc.dart';
import 'package:tech_haven/vendor/features/revenue/data/datasource/revenue_data_source.dart';
import 'package:tech_haven/vendor/features/revenue/data/datasource/revenue_data_source_impl.dart';
import 'package:tech_haven/vendor/features/revenue/data/repositories/revenue_repository_impl.dart';
import 'package:tech_haven/vendor/features/revenue/domain/repository/revenue_repository.dart';
import 'package:tech_haven/vendor/features/revenue/domain/usecase/get_list_of_revenue_date.dart';
import 'package:tech_haven/vendor/features/revenue/domain/usecase/get_revenue.dart';
import 'package:tech_haven/vendor/features/revenue/presentation/bloc/revenue_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseStorage.instance);
  serviceLocator.registerLazySingleton(() => GoogleSignIn());
  _initAuth();
  _initHomePage();
  _initDetailsPage();
  _initDataCommon();
  _initSearchCategory();
  _initRegisterProduct();
  _initManageProduct();
  _initHelpCenter();
  _initFavorite();
  _initProfile();
  _initCart();
  _intiCheckout();
  _initMap();
  _initRegisterVendor();
  _initProductsPage();
  _initVendorOrderPage();
  _initVendorOrderDetailsPage();
  _initRevenue();
  _initSearchpage();
  _initUserOrderPage();
  _initReviewEnterPage();
  _initUserOrderHistoryPage();
  _initReviewPage();
  _initProfileEditPage();
  _initOrderedProductsPage();
  _initVendorProfilePage();
}

void _initOrderedProductsPage() {
  serviceLocator
    ..registerFactory<OrderedProductsPageDataSource>(
        () => OrderedProductsPageDataSourceImpl(serviceLocator()))
    ..registerFactory<OrderedProductsPageRepository>(
        () => OrderedProductsPageRepositoryImpl(serviceLocator()))
    ..registerFactory(() => GetUserOrderProducts(serviceLocator()))
    ..registerLazySingleton(() => OrderedProductsPageBloc(
        getUserOrderProducts: serviceLocator(), getUserData: serviceLocator()));
}

void _initProfileEditPage() {
  serviceLocator
    ..registerFactory<ProfileEditPageDataSource>(() =>
        ProfileEditPageDataSourceImpl(
            firebaseFirestore: serviceLocator(),
            firebaseStorage: serviceLocator()))
    ..registerFactory<ProfileEditPageRepository>(() =>
        ProfileEditPageRepositoryImpl(
            profileEditPageDataSource: serviceLocator()))
    ..registerFactory(() => UpdateUserData(serviceLocator()))
    ..registerLazySingleton(() => ProfileEditPageBloc(
        getUserData: serviceLocator(), updateUserData: serviceLocator()));
}

void _initReviewPage() {
  serviceLocator
    ..registerFactory<ReviewPageDataSource>(
        () => ReviewPageDataSourceImpl(serviceLocator()))
    ..registerFactory<ReviewPageRepository>(
        () => ReviewPageRepositoryImpl(serviceLocator()))
    ..registerFactory(
        () => UpdateUserHelpful(reviewPageRepository: serviceLocator()))
    ..registerLazySingleton(
        () => ReviewPageBloc(updateUserHelpful: serviceLocator()));
}

void _initHelpCenter() {
  serviceLocator
    ..registerFactory<HelpCenterDataSource>(
        () => HelpCenterDataSourceImpl(serviceLocator()))
    ..registerFactory<HelpCenterRepository>(
        () => HelpCenterRepositoryImpl(serviceLocator()))
    ..registerFactory(
        () => SendHelpRequestUseCase(helpCenterRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllUserRequestsUseCase(helpCenterRepository: serviceLocator()))
    ..registerLazySingleton(() => HelpCenterBloc(
        sendHelpRequestUseCase: serviceLocator(),
        getUserData: serviceLocator(),
        getAllUserRequestsUseCase: serviceLocator()));
}

void _initUserOrderHistoryPage() {
  serviceLocator
    ..registerFactory<UserOrderHistoryDataSource>(
        () => UserOrderHistoryDataSourceImpl(serviceLocator()))
    ..registerFactory<UserOrderHistoryRepository>(
        () => UserOrderHistoryRepositoryImpl(serviceLocator()))
    ..registerFactory(() => GetAllUserOrderHistoryUseCase(
        userOrderHistoryRepository: serviceLocator()))
    ..registerLazySingleton(() => UserOrderHistoryPageBloc(
        getAllUserOrderHistoryUseCase: serviceLocator(),
        getUserData: serviceLocator()));
}

void _initReviewEnterPage() {
  serviceLocator.registerLazySingleton(
      () => ReviewEnterPageBloc(addReview: serviceLocator()));
}

void _initSearchpage() {
  serviceLocator
    ..registerFactory<SearchPageDataSource>(
        () => SearchPageDataSourceImpl(serviceLocator()))
    ..registerFactory<SearchPageRepository>(
        () => SearchPageRepositoryImpl(serviceLocator()))
    ..registerFactory(() => SearchProducts(serviceLocator()))
    ..registerLazySingleton(() => SearchPageBloc(
          getAllProduct: serviceLocator(),
          getAllFavorite: serviceLocator(),
          updateProductToFavorite: serviceLocator(),
          updateProductToCart: serviceLocator(),
          getAllCart: serviceLocator(),
          getAllCategory: serviceLocator(),
          getAllBrands: serviceLocator(),
        ));
}

void _initUserOrderPage() {
  serviceLocator.registerLazySingleton(() => UserOrderPageBloc(
      getAllOrders: serviceLocator(), getAProduct: serviceLocator()));
}

void _initRevenue() {
  serviceLocator
    ..registerFactory<RevenueDataSource>(
        () => RevenueDataSourceImpl(firebaseFirestore: serviceLocator()))
    ..registerFactory<RevenueRepository>(
        () => RevenueRepositoryImpl(revenueDataSource: serviceLocator()))
    ..registerFactory(() => GetRevenue(revenueRepository: serviceLocator()))
    ..registerFactory(
        () => GetListOfRevenueData(revenueRepository: serviceLocator()))
    ..registerLazySingleton(() => RevenueBloc(
        getUserData: serviceLocator(),
        getRevenue: serviceLocator(),
        getListOfRevenueData: serviceLocator()));
}

void _initVendorOrderDetailsPage() {
  serviceLocator.registerLazySingleton(
    () => VendorOrderDetailsBloc(
      getAProduct: serviceLocator(),
      getAllProduct: serviceLocator(),
    ),
  );
}

void _initVendorOrderPage() {
  serviceLocator
    ..registerFactory<OrderDataSource>(
        () => OrderDataSourceImpl(firebaseFirestore: serviceLocator()))
    ..registerFactory<OrderRepository>(
        () => OrderRepositoryImpl(orderDataSource: serviceLocator()))
    ..registerFactory(
        () => DeliverOrderToAdmin(orderRepository: serviceLocator()))
    ..registerLazySingleton(() => VendorOrderPageBloc(
        getVendorOrders: serviceLocator(),
        getAllOrders: serviceLocator(),
        getAProduct: serviceLocator(),
        deliverOrderToAdmin: serviceLocator()));
}

void _initRegisterVendor() {
  List<String> hello = ['s', 'sdf'];
  hello.reversed;
  serviceLocator

  
    ..registerFactory<RegisterVendorDataSource>(() =>
        RegisterVendorDataSourceImpl(
            firebaseAuth: serviceLocator(),
            firebaseFirestore: serviceLocator(),
            firebaseStorage: serviceLocator()))
    ..registerFactory<RegisterVendorRepository>(() =>
        RegisterVendorRepositoryImpl(
            registerVendorDataSource: serviceLocator()))
    ..registerFactory(
        () => SendRequestForVendor(registerVendorRepository: serviceLocator()))
    ..registerLazySingleton(() => RegisterVendorBloc(
        sendRequestForVendor: serviceLocator(),
        getVendorData: serviceLocator()));
}

void _initProfile() {
  serviceLocator
    ..registerFactory<UserProfilePageDataSource>(() =>
        UserProfilePageDataSourceImpl(
            firebaseAuth: serviceLocator(), firestore: serviceLocator()))
    ..registerFactory<UserProfilePageRepository>(
        () => UserProfilePageRepositoryImpl(serviceLocator()))
    ..registerFactory(() => SendOtpForGoogleLogin(serviceLocator()))
    ..registerLazySingleton(() => ProfileBloc(
        getUserData: serviceLocator(),
        sendOtpForGoogleLogin: serviceLocator()));
}

void _initProductsPage() {
  serviceLocator.registerLazySingleton(() => ProductsPageBloc(
      getAllProduct: serviceLocator(),
      getAllCart: serviceLocator(),
      updateProductToFavorite: serviceLocator(),
      getAllFavorite: serviceLocator(),
      updateProductToCart: serviceLocator()));
}

void _intiCheckout() {
  serviceLocator
    ..registerFactory<CheckoutDataSource>(() => CheckoutDataSourceImpl(
        firebaseFirestore: serviceLocator(), firebaseAuth: serviceLocator()))
    ..registerFactory<CheckoutRepository>(
        () => CheckoutRepositoryImpl(checkoutDataSource: serviceLocator()))
    ..registerFactory(
        () => ShowPresentPaymentSheet(checkoutRepository: serviceLocator()))
    ..registerFactory(() => SendOrder(checkoutRepository: serviceLocator()))
    ..registerFactory(() => SaveUserAddress(serviceLocator()))
    ..registerFactory(
        () => GetAllUserAddress(checkoutRepository: serviceLocator()))
    ..registerFactory(
        () => SubmitPaymentForm(checkoutRepository: serviceLocator()))
    ..registerLazySingleton(() => CheckoutBloc(
        submitPaymentForm: serviceLocator(),
        showPresentPaymentSheet: serviceLocator(),
        getAllUserAddress: serviceLocator(),
        getAllCart: serviceLocator(),
        saveUserAddress: serviceLocator(),
        updateProductFields: serviceLocator(),
        updateProductToCart: serviceLocator(),
        getAProduct: serviceLocator(),
        sendOrder: serviceLocator(),
        getAllCartProduct: serviceLocator(),
        getAllProduct: serviceLocator(),
        getUserData: serviceLocator()));
}

void _initMap() {
  serviceLocator.registerLazySingleton(() => MapPageBloc(
      updateLocation: serviceLocator(),
      getCurrentLocationDetails: serviceLocator(),
      getUserData: serviceLocator()));
}

_initAuth() {
  //for user cubit

  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseStorage: serviceLocator(),
        googleSignIn: serviceLocator(),
        firebaseAuth: serviceLocator(),
        firebaseFirestore: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // phonenumberverification
    ..registerFactory(
      () => SendOTPToPhoneNumber(serviceLocator()),
    )
    ..registerFactory(() => VerifyPhoneAndSignUpUser(serviceLocator()))
    ..registerFactory(() => CreateUser(authRepository: serviceLocator()))
    ..registerFactory(() => UserSignIn(authRepository: serviceLocator()))
    ..registerFactory(() => GoogleSignUp(authRepository: serviceLocator()))
    ..registerFactory(
        () => ForgotPasswordSendEmail(authRepository: serviceLocator()))
    ..registerFactory(() => UpdateUserPhoneNumber(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
          updateUserPhoneNumber: serviceLocator(),
          sendOTPToPhoneNumber: serviceLocator(),
          verifyPhoneAndSignUpUser: serviceLocator(),
          createUser: serviceLocator(),
          userSignIn: serviceLocator(),
          googleSignUp: serviceLocator(),
          appUserCubit: serviceLocator(),
          forgotPasswordSendEmail: serviceLocator()),
    );
}

_initDataCommon() {
  serviceLocator
    ..registerFactory<DataSource>(() => DataSourceImpl(
        firebaseAuth: serviceLocator(), firebaseFirestore: serviceLocator()))
    ..registerFactory<Repository>(
        () => RepositoryImpl(dataSource: serviceLocator()))
    ..registerFactory(() => GetAllCategory(repository: serviceLocator()))
    ..registerFactory(() => GetAllProduct(repository: serviceLocator()))
    ..registerFactory(() => AddReview(serviceLocator()))
    ..registerFactory(() => GetProductReview(repository: serviceLocator()))
    ..registerFactory(() => GetImagesForProduct(repository: serviceLocator()))
    ..registerFactory(() => GetAllCart(repository: serviceLocator()))
    ..registerFactory(() => GetAllBrands(repository: serviceLocator()))
    ..registerFactory(() => GetUserData(repository: serviceLocator()))
    ..registerFactory(() => GetAllReviewsProduct(repository: serviceLocator()))
    ..registerFactory(() => GetAProduct(repository: serviceLocator()))
    ..registerFactory(() => GetAllFavorite(repository: serviceLocator()))
    ..registerFactory(() => GetUserOwnedProducts(repository: serviceLocator()))
    ..registerFactory(() => GetAllCartProduct(repository: serviceLocator()))
    ..registerFactory(
        () => GetAllBrandRelatedProduct(repository: serviceLocator()))
    ..registerFactory(() => UpdateLocation(repository: serviceLocator()))
    ..registerFactory(
        () => GetCurrentLocationDetails(repository: serviceLocator()))
    ..registerFactory(() => GetAllOrders(repository: serviceLocator()))
    ..registerFactory(() => GetVendorOrders(repository: serviceLocator()))
    ..registerFactory(
        () => GetAllFavoritedProduct(repository: serviceLocator()))
    ..registerFactory(() => UpdateProductFields(repository: serviceLocator()))
    ..registerFactory(
        () => UpdateProductToFavorite(repository: serviceLocator()))
    ..registerFactory(() => UpdateProductToCart(repository: serviceLocator()))
    ..registerFactory(() => GetVendorData(repository: serviceLocator()))
    ..registerLazySingleton(() => CommonBloc(
        getCurrentLocationDetails: serviceLocator(),
        updateProductToFavorite: serviceLocator(),
        getUserData: serviceLocator()));
}

void _initHomePage() {
  serviceLocator
    ..registerFactory<HomePageDataSource>(() => HomePageDataSourceImpl(
        dataSource: serviceLocator(), firebaseFirestore: serviceLocator()))
    ..registerFactory<HomePageRepository>(
        () => HomePageRepositoryImpl(homePageDataSource: serviceLocator()))
    ..registerFactory(
        () => GetAllSubCategoriesHomePage(homePageRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllBannerHomePage(homePageRepository: serviceLocator()))
    ..registerFactory(() => FetchTrendingProduct(serviceLocator()))
    ..registerLazySingleton(() => HomePageBloc(
        // getAllReviewsProduct: ,
        fetchTrendingProduct: serviceLocator(),
        getAProduct: serviceLocator(),
        getAllProduct: serviceLocator(),
        getAllBannerHomePage: serviceLocator(),
        updateProductToFavorite: serviceLocator(),
        updateProductToCart: serviceLocator(),
        getAllCart: serviceLocator(),
        getAllSubCategoriesHomePage: serviceLocator(),
        getAllFavorite: serviceLocator(),
        getUserOwnedProducts: serviceLocator()));
}

_initDetailsPage() {
  serviceLocator.registerLazySingleton(() => DetailsPageBloc(
      getImagesForProduct: serviceLocator(),
      getUserOwnedProducts: serviceLocator(),
      getUserData: serviceLocator(),
      getAllReviewsProduct: serviceLocator(),
      getAllCart: serviceLocator(),
      getAllFavorite: serviceLocator(),
      updateProductToFavorite: serviceLocator(),
      getAllBrandRelatedProduct: serviceLocator(),
      updateProductToCart: serviceLocator(),
      getProductReview: serviceLocator()));
}

void _initSearchCategory() {
  serviceLocator
    ..registerFactory<SearchCategoryDataSource>(
        () => SearchCategoryDataSourceImpl(dataSource: serviceLocator()))
    ..registerFactory<SearchCategoryRepository>(() =>
        SearchCategoryRepositoryImpl(
            searchCategoryDataSource: serviceLocator()))
    ..registerLazySingleton(
        () => SearchCategoryBloc(getAllCategory: serviceLocator()))
    ..registerLazySingleton(
      () => SearchCategoryCubit(),
    )
    ..registerLazySingleton(() => SearchCategoryAccordionCubit());
}

void _initVendorProfilePage() {
  serviceLocator
    ..registerFactory<VendorProfileDataSource>(
        () => VendorProfileDataSourceImpl(firestore: serviceLocator()))
    ..registerFactory<VendorProfileRepository>(() =>
        VendorProfileRepositoryImpl(vendorProfileDataSource: serviceLocator()))
    ..registerFactory(
        () => GetVendorProfile(vendorRepository: serviceLocator()))
    ..registerLazySingleton(() => VendorProfileBloc(
        getVendorProfile: serviceLocator(), getUserData: serviceLocator()));
}

_initRegisterProduct() {
  serviceLocator
    ..registerFactory<RegisterProductDataSource>(() =>
        RegisterProductDataSourceImpl(
            dataSource: serviceLocator(),
            firebaseAuth: serviceLocator(),
            firebaseFirestore: serviceLocator(),
            firebaseStorage: serviceLocator()))
    ..registerFactory<RegisterProductRepository>(() =>
        RegisterProductRepositoryImpl(
            registerProductDataSource: serviceLocator()))
    ..registerFactory(() => GetAllCategoryForRegister(
          registerProductRepository: serviceLocator(),
        ))
    ..registerFactory(
        () => RegisterNewProduct(registerProductRepository: serviceLocator()))
    ..registerFactory(
        () => DeleteProduct(registerProductRepository: serviceLocator()))
    ..registerFactory(() =>
        UpdateExistingProduct(registerProductRepository: serviceLocator()))
    ..registerLazySingleton(() => RegisterProductBloc(
          getAllCategoryForRegister: serviceLocator(),
          registerNewProduct: serviceLocator(),
          deleteProduct: serviceLocator(),
          updateExistingProduct: serviceLocator(),
          getAllBrands: serviceLocator(),
        ))
    ..registerLazySingleton(
        () => GetImagesBloc(getImagesForProduct: serviceLocator()));
}

_initManageProduct() {
  serviceLocator
    ..registerFactory<ManageProductDataSource>(
      () => ManageProductDataSourceImpl(
        firebaseFirestore: serviceLocator(),
        dataSource: serviceLocator(),
      ),
    )
    ..registerFactory<ManageProductRepository>(() =>
        ManageProductRepositoryImpl(manageProductDataSource: serviceLocator()))
    ..registerFactory(
        () => GetAllProducts(manageProductRepository: serviceLocator()))
    ..registerFactory(() =>
        UpdateTheProductPublish(manageProductRepository: serviceLocator()))
    ..registerLazySingleton(() => ManageProductBloc(
        updateTheProductPublish: serviceLocator(),
        getAllProducts: serviceLocator(),
        getUserData: serviceLocator()));
}

_initFavorite() {
  serviceLocator
    ..registerFactory<FavoritePageDataSource>(() => FavoritePageDataSourceImpl(
        dataSource: serviceLocator(), firebaseFirestore: serviceLocator()))
    ..registerFactory<FavoritePageRepository>(() =>
        FavoritePageRepositoryImpl(favoritePageDataSource: serviceLocator()))
    ..registerFactory(() => GetAllFavoritedProductFavoritePage(
        favoritePageRepository: serviceLocator()))
    ..registerFactory(
        () => RemoveProductFavorite(favoritePageRepository: serviceLocator()))
    ..registerLazySingleton(() => FavoritePageBloc(
        getAllFavoritedProduct: serviceLocator(),
        removeProductFavorite: serviceLocator()));
}

_initCart() {
  serviceLocator.registerLazySingleton(() => CartPageBloc(
      getAllProduct: serviceLocator(),
      updateProductToFavorite: serviceLocator(),
      getAllCartProduct: serviceLocator(),
      getAllFavorite: serviceLocator(),
      updateProductToCart: serviceLocator(),
      getAllCart: serviceLocator()));
}
