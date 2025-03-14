import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/common/data/model/location_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/common/data/model/product_review_model.dart';
import 'package:tech_haven/core/common/data/model/review_model.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';
import 'package:tech_haven/vendor/features/registervendor/data/models/vendor_model.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';

abstract class DataSource {
  Future<UserModel?> getUserData();
  Future<VendorModel?> getVendorData({required String vendorID});
  Future<ProductModel> getAProduct({required String productID});
  Future<List<CategoryModel>> getAllCategory(bool refresh);
  Future<List<ProductModel>> getAllProduct();
  Future<List<ProductModel>> getAllCartProduct();
  Future<List<ProductModel>> getAllFavoriteProduct();
  Future<bool> updateProductToFavorite(
      {required bool isFavorited, required Product product});
  Future<List<String>> getAllFavorite();
  Future<List<CartModel>> getAllCart();
  Future<bool> updateProductToCart(
      {required int itemCount, required Product product, required Cart? cart});

  Future<List<CategoryModel>> getAllSubCategory();
  Future<Map<int, List<Image>>> getImagesForProduct(
      {required String productID});
  Future<List<ProductModel>> getAllBrandRelatedProduct(
      {required Product product});
  Future<bool> updateLocation(
      {required String name,
      required String phoneNumber,
      required String location,
      required String apartmentHouseNumber,
      required String emailAddress,
      required String addressInstructions});

  Future<LocationModel?> getCurrentLocationDetails();
  Future<List<CategoryModel>> getAllBrands();
  Future<String> updateProductFields(
      String productID, Map<String, dynamic> updates);

  Future<List<OrderModel>> getAllOrders();
  Future<List<OrderModel>> getVendorOrders();
  Future<List<String>> getUserOwnedProducts();
  Future<List<ReviewModel>> getAllReviewsProduct({required String productID});
  Future<void> addReview(
      {required Product product,
      required String userReview,
      required List<Review> listOfReview,
      required double userRating});
  Future<ProductReviewModel> getProductReviewModel({required String productID});
  // Future<List<OrderModel>> getUserOrders();
  // Future<List<PaymentModel>> getPaymentModels();
}
