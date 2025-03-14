import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class UpdateProductFields
    implements UseCase<String, UpdateProductFieldsParams> {
  final Repository repository;
  UpdateProductFields({required this.repository});

  @override
  Future<Either<Failure, String>> call(
      UpdateProductFieldsParams params) async {
    return await repository.updateProductFields(productID: params.productID,updates: params.updates);
  }
}


class UpdateProductFieldsParams {
  final String productID;
  final Map<String, dynamic> updates;
  UpdateProductFieldsParams({required this.updates, required this.productID});
}
