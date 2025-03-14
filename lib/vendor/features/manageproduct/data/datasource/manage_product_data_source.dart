import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/entities/product.dart';

abstract class ManageProductDataSource {
  Future<List<ProductModel>> getAllProducts();

  Future<void> updateTheProductPublish({required Product product, required bool publish});
}
