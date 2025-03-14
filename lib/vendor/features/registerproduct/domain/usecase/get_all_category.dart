import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';

class GetAllCategoryForRegister implements UseCase<List<Category>, GetAllCategoryForRegiseterParams> {
  final RegisterProductRepository registerProductRepository;
  GetAllCategoryForRegister({
    required this.registerProductRepository,
  });

  @override
  Future<Either<Failure, List<Category>>> call(GetAllCategoryForRegiseterParams params) async {
    return await registerProductRepository.getAllCategories(params.refresh);
  }
}

class GetAllCategoryForRegiseterParams {
  final bool refresh;
  GetAllCategoryForRegiseterParams({required this.refresh});
}
