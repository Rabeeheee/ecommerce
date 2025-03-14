import 'package:tech_haven/core/common/data/model/user_ordered_product_model.dart';

abstract class OrderedProductsPageDataSource {
  Future<List<UserOrderedProductModel>> getUserOrderProducts(String userId, String orderId);
}