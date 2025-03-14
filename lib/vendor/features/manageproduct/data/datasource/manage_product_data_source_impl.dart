import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/vendor/features/manageproduct/data/datasource/manage_product_data_source.dart';

class ManageProductDataSourceImpl extends ManageProductDataSource {
  final DataSource dataSource;
  final FirebaseFirestore firebaseFirestore;
  ManageProductDataSourceImpl(
      {required this.dataSource, required this.firebaseFirestore});
  @override
  Future<List<ProductModel>> getAllProducts() {
    try {
      final allProducts = dataSource.getAllProduct();
      return allProducts;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateTheProductPublish(
      {required Product product, required bool publish}) async {
    try {
      await firebaseFirestore
          .collection('products')
          .doc(product.productID)
          .update({'isPublished': publish});
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
