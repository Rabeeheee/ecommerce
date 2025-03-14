import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

import '../../../../../core/usecase/usecase.dart';

class GetAllSubCategoriesHomePage implements UseCase<List<Category>, NoParams> {
  final HomePageRepository homePageRepository;
  GetAllSubCategoriesHomePage({required this.homePageRepository});

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await homePageRepository.getAllSubCategories();
  }
}
