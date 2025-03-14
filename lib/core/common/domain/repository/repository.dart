import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/location.dart';
import 'package:tech_haven/core/entities/product.dart';

import 'package:tech_haven/core/entities/product_review.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/entities/vendor.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class Repository {
  Future<Either<Failure, List<Product>>> getAllProduct();
  Future<Either<Failure, List<Product>>> getAllCartProduct();
  Future<Either<Failure, List<Product>>> getAllFavoriteProduct();
    Future<Either<Failure, List<Category>>> getAllBrands();
  Future<Either<Failure,Product>> getAProduct({required String productID});
  // Future<Either<Failure, List<Category>>> getAllSubCategory();
  Future<Either<Failure, bool>> updateProductToFavorite({
    required bool isFavorited,
    required Product product,
  });
  Future<Either<Failure, List<String>>> getAllFavorite();
  Future<Either<Failure, bool>> updateProductToCart({
    required int itemCount,
    required Product product,
    required Cart? cart,
  });
  Future<Either<Failure,List<String>>> getUserOwnedProducts();
  Future<Either<Failure, List<Cart>>> getAllCart();
  Future<Either<Failure, List<Category>>> getAllCategory();
  Future<Either<Failure, Map<int, List<Image>>>> getImagesForProduct(
      {required String productID});
  Future<Either<Failure, List<Product>>> getAllBrandRelatedProduct(
      {required Product product});
  Future<Either<Failure, bool>> updateLocation(
      {required String name,
      required String phoneNumber,
      required String location,
      required String apartmentHouseNumber,
      required String emailAddress,
      required String addressInstructions});

  Future<Either<Failure, String>> updateProductFields({required String productID, required Map<String,dynamic> updates});

  Future<Either<Failure, Location?>> getCurrentLocationDetails();
  Future<Either<Failure, User?>> getUserData();
  Future<Either<Failure, Vendor?>> getVendorData({required String vendorID});

  Future<Either<Failure,List<OrderModel>>> getAllOrders();
    Future<Either<Failure,List<OrderModel>>> getVendorOrders();
        Future<Either<Failure,List<Review>>> getAllReviewsProduct({required String productID});
        Future<Either<Failure,void>>  addReview({required Product product,required String userReview,required double userRating,required List<Review> listOfReviews});
          Future<Either<Failure,ProductReview>> getProductReviewModel({required String productID});
}
