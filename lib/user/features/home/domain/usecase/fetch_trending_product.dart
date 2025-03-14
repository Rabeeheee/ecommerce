
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/trending_product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

class FetchTrendingProduct implements UseCase<TrendingProduct, NoParams> {
  final HomePageRepository repository;

  FetchTrendingProduct(this.repository);

  @override
  Future<Either<Failure, TrendingProduct>> call(NoParams params) async {
    return repository.getTrendingProduct();
  }
}
