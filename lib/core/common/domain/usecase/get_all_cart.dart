import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetAllCart implements UseCase<List<Cart>, NoParams> {
  final Repository repository;
  GetAllCart({required this.repository});

  @override
  Future<Either<Failure, List<Cart>>> call(NoParams params) async {
    return await repository.getAllCart();
  }
}
